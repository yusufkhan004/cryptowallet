// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:cryptowallet/pages/sign_in/authentication.dart';
import 'package:cryptowallet/pages/sign_in/homescreen.dart';
import 'package:cryptowallet/pages/sign_in/widgets/forgetpasswordpage.dart';
import 'package:cryptowallet/pages/sign_in/widgets/google_sign_in_button.dart';
import 'package:cryptowallet/pages/sign_up/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  //formKey
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // void _showButtonPressDialog(BuildContext context, String provider) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text('$provider Button Pressed!'),
  //     backgroundColor: Colors.black26,
  //     duration: Duration(milliseconds: 400),
  //   ));
  // }

// login function
  void signIn(String email, String password) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then(
            (uid) => {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                    backgroundColor: Color(0xff347af0),
                    duration: const Duration(seconds: 10),
                    content: Text("Successfully Logged In")),
              ),
              Navigator.of(context, rootNavigator: true).pop(),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen())),
            },
          )
          .catchError(
        (e) {
          Navigator.of(context, rootNavigator: true).pop();
          Scaffold.of(context).showSnackBar(
            SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 10),
                content: Text(e.message)),
          );
        },
      );
    }
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 50,
      ),
      decoration: BoxDecoration(
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
                // email Field
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                  ),
                  autocorrect: false,
                  autofocus: false,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter your Email");
                    }
                    //reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter your valid Email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                // password Field
                TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  controller: _passwordController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');

                    if (value!.isEmpty) {
                      return ("Please Enter your password");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter a valid password(Min. 6 Character)");
                    }
                  },
                  onSaved: (value) {
                    _passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      child: Text(
                        'Forget your password?',
                        style: TextStyle(
                          color: Color(0xff347af0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            // ignore: deprecated_member_use
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    // FocusScope.of(context).unfocus();
                    signIn(_emailController.text, _passwordController.text);
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
                      'Login',
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
                  children: <Widget>[
                    const Text(
                      'Doesn\'t have an account?',
                      style: TextStyle(
                        color: Color(0xff485068),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        ' Sign Up?',
                        style: TextStyle(
                          color: Color(0xff347af0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Color(0xff347af0),
                          thickness: 1,
                          height: 20,
                        )),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Color(0xff347af0),
                          thickness: 1,
                          height: 20,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: _initializeFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent.shade700,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
