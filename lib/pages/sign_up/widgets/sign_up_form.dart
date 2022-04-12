// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, dead_code, unnecessary_null_comparison, unused_local_variable

import 'dart:io';
import 'package:cryptowallet/pages/sign_in/homescreen.dart';
import 'package:cryptowallet/pages/sign_up/widgets/email_verification.dart';
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();

  bool isEmailVerified = false;

// editing controller
  final nameEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  Future signUp(
      String name, String username, String email, String password) async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(child: CircularProgressIndicator()),
    // );

    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) => {postDetailsToFirestore(name, username)})
          .catchError((e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            duration: Duration(seconds: 10),
            content: Text(e!.message),
          ),
        );
        dispose();
        // Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore(String name, String username) async {
    // calling a firestore
    // calling user model
    // sending these value

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
      name: name,
      username: username,
      uid: user!.uid,
      email: user.email,
      phone: "",
      image: _imageFile,
      aboutMeDescription: "",
    );

    // writing all values

    // userModel.uid = user!.uid;
    // userModel.username = usernameEditingController.text;
    // userModel.email = user.email;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    // Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: true).pop();
    // dispose();

    Scaffold.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        backgroundColor: Color(0xff347af0),
        duration: const Duration(seconds: 10),
        content: Text("Account created successfully."),
      ),
    );

    Navigator.push(
      (context),
      MaterialPageRoute(builder: (context) => EmailVerification()),
    );
  }

  Uri? _imageFile;
  bool _load = false;
  final ImagePicker _picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile! as Uri?;
      _load = false;
    });
  }

  bool _isObscurep = true;
  bool _isObscurecp = true;
  @override
  Widget build(BuildContext context) {
    Widget bottomSheet() {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () => takePhoto(ImageSource.camera),
                  label: Text("Camera"),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () => takePhoto(ImageSource.gallery),
                  label: Text("Gallery"),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 40,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15.0,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              size: 19.0,
                              color: Color(0xFF404040),
                            ),
                          ),
                        ),
                      ),
                      radius: 38.0,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          // NetworkImage(
                          _imageFile == null
                              ? AssetImage("assets/images/img.png")
                              : FileImage(File(_imageFile!.path))
                                  as ImageProvider,
                      // ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_sharp),
                    labelText: 'Name',
                  ),
                  autofocus: false,
                  controller: nameEditingController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');

                    if (value!.isEmpty) {
                      return ("Name cannot be empty");
                    }
                    if (value.length < 3) {
                      return ("Please Enter the name of min 3 characters");
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   usernameEditingController.text = value!;
                  // },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_sharp),
                    labelText: 'Username',
                  ),
                  autofocus: false,
                  controller: usernameEditingController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');

                    if (value!.isEmpty) {
                      return ("Name cannot be empty");
                    }
                    if (value.length < 3) {
                      return ("Please Enter the name of min 3 characters");
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   usernameEditingController.text = value!;
                  // },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                  ),
                  autofocus: false,
                  controller: emailEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Email cannot be empty");
                    }
                    //reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter your valid Email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailEditingController.text = value!.trim();
                  },
                ),
                TextFormField(
                  obscureText: _isObscurep,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscurep ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscurep = !_isObscurep;
                          });
                        }),
                  ),
                  autofocus: false,
                  controller: passwordEditingController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');

                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter a valid password(Min. 6 Character)");
                    }
                  },
                  onSaved: (value) {
                    passwordEditingController.text = value!.trim();
                  },
                ),
                TextFormField(
                  obscureText: _isObscurecp,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscurecp
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscurecp = !_isObscurecp;
                          });
                        }),
                  ),
                  autofocus: false,
                  controller: confirmPasswordEditingController,
                  validator: (value) {
                    if (confirmPasswordEditingController.text !=
                        passwordEditingController.text) {
                      return "Password do not matched";
                    }
                    if (value!.isEmpty) {
                      return ("Confirm password is require to check password");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPasswordEditingController.text = value!.trim();
                  },
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
            // ignore: deprecated_member_use
            Column(children: <Widget>[
              FlatButton(
                onPressed: () {
                  signUp(
                      nameEditingController.text,
                      usernameEditingController.text,
                      emailEditingController.text,
                      passwordEditingController.text);
                },
                color: const Color(0xff347af0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: const BorderSide(
                    color: Color(0xff347af0),
                  ),
                ),
                child: Container(
                  width: 160,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color(0xff485068),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Login?',
                      style: TextStyle(
                        color: Color(0xff347af0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }

  void dispose() {
    nameEditingController.clear();
    usernameEditingController.clear();
    emailEditingController.clear();
    passwordEditingController.clear();
    confirmPasswordEditingController.clear();
    // super.dispose();
  }
}
