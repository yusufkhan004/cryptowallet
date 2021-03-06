// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/pages/profile_body/widgets/appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditUsernameFormPage extends StatefulWidget {
  const EditUsernameFormPage({Key? key}) : super(key: key);

  @override
  EditUsernameFormPageState createState() {
    return EditUsernameFormPageState();
  }
}

class EditUsernameFormPageState extends State<EditUsernameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final UsernameController = TextEditingController();
  User? mainUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    UsernameController.dispose();
    super.dispose();
  }

  void updateUserValue(String username) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(mainUser!.uid)
        .update({'username': username});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 330,
                    child: const Text(
                      "Edit Your Username",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 250,
                            child: TextFormField(
                              // Handles Form Validation for First Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Username';
                                } else if (value.contains("[a-zA-Z]+") ==
                                    true) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Enter your new Username'),
                              controller: UsernameController,
                            ))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 160,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                            color: Color(0xff347af0),
                          ),
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate() &&
                              (UsernameController.text).contains("[a-zA-Z]+") ==
                                  false) {
                            updateUserValue(UsernameController.text);
                            Navigator.pop(context);
                          }
                        },
                        color: Color(0xff347af0),
                        child: Container(
                          width: 160,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.check_circle_rounded,
                                  color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Done',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
