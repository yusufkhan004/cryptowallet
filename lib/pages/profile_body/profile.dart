// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_description.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_email.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_image.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_name.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_username.dart';
import 'package:cryptowallet/pages/profile_body/pages/edit_phone.dart';
// import 'package:cryptowallet/pages/profile_body/user/user.dart';
// import 'package:cryptowallet/pages/profile_body/user/user_data.dart';
import 'package:cryptowallet/pages/profile_body/widgets/display_image_widget.dart';
import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? mainUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> getUserInfo() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(mainUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xffe0e9f8),
        backgroundColor: Colors.white,
        title: Text("Profile",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            )),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getUserInfo(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            // InkWell(
                            //     onTap: () {
                            //       navigateSecondPage(EditImagePage());
                            //     },
                            //     child: DisplayImage(
                            //       // imagePath: mainUser?.photoURL,
                            //       onPressed: () {},
                            //     )),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 3),
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff347af0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe0e9f8),
                                        borderRadius: BorderRadius.circular(20),
                                        shape: BoxShape.rectangle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3.0,
                                          ),
                                        ]),
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    // padding: EdgeInsets.all(20),
                                    width:
                                        MediaQuery.of(context).size.width * 1.0,

                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              navigateSecondPage(
                                                  EditNameFormPage());
                                            },
                                            child: Center(
                                              child: Text(
                                                snapshot.data!["name"],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  height: 1.4,
                                                  color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xff347af0),
                                          size: 40.0,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 3),
                                    child: Text(
                                      'Username',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff347af0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe0e9f8),
                                        borderRadius: BorderRadius.circular(20),
                                        shape: BoxShape.rectangle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3.0,
                                          ),
                                        ]),
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    // padding: EdgeInsets.all(20),
                                    width:
                                        MediaQuery.of(context).size.width * 1.0,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              navigateSecondPage(
                                                  EditUsernameFormPage());
                                            },
                                            child: Center(
                                              child: Text(
                                                snapshot.data!["username"],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  height: 1.4,
                                                  color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xff347af0),
                                          size: 40.0,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(
                            //   height: 15,
                            // ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 3),
                                      child: Text(
                                        'Email Id',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff347af0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xffe0e9f8),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 3.0,
                                            ),
                                          ]),
                                      margin:
                                          EdgeInsets.only(left: 15, right: 15),
                                      // padding: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              // onPressed: () {
                                              //   navigateSecondPage(
                                              //       EditEmailFormPage());
                                              // },
                                              onTap: () {},

                                              child: Center(
                                                child: Text(
                                                  snapshot.data!["email"],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    height: 1.4,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Color(0xff347af0),
                                            size: 40.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            ////

                            // SizedBox(
                            //   height: 15,
                            // ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 3),
                                      child: Text(
                                        'Phone No.',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff347af0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xffe0e9f8),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            shape: BoxShape.rectangle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3.0,
                                              ),
                                            ]),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15),
                                        // padding: EdgeInsets.all(20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.0,
                                        child: Row(children: [
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                navigateSecondPage(
                                                    EditPhoneFormPage());
                                              },
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!["phone"],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    height: 1.4,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Color(0xff347af0),
                                            size: 40.0,
                                          )
                                        ]))
                                  ],
                                )),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 3),
                                    child: Text(
                                      'Bio',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff347af0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe0e9f8),
                                        borderRadius: BorderRadius.circular(20),
                                        shape: BoxShape.rectangle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3.0,
                                          ),
                                        ]),
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    // padding: EdgeInsets.all(20),
                                    width:
                                        MediaQuery.of(context).size.width * 1.0,
                                    // width: 350,
                                    // height: 150,
                                    // decoration: BoxDecoration(
                                    //     border: Border(
                                    //         bottom: BorderSide(
                                    //   color: Colors.grey,
                                    //   width: 1,
                                    // ))),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    navigateSecondPage(
                                                        EditDescriptionFormPage());
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 10, 10),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            snapshot
                                                                .data!["about"],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              height: 1.4,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ))))),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Color(0xff347af0),
                                            size: 40.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                _signOut();
                                // Navigator.pop(context, false);
                              },
                              color: Colors.red,
                              child: Container(
                                width: 160,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.exit_to_app,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'Log Out',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInPage()),
            (route) => false));
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
