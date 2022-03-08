// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cryptowallet/pages/sign_in/homescreen.dart';
import 'package:cryptowallet/pages/sign_up/widgets/customalertdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  // bool isEmailVerified = false;

  // @override
  // void initState() {
  //   super.initState();

  //   // user needs to be created before!
  //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  //   if (!isEmailVerified) {
  //     sendVerificationEmail();
  //   }
  // }

  // Future sendVerificationEmail() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser!;
  //     await user.sendEmailVerification();
  //   } catch (e) {
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(20),
  //             topLeft: Radius.circular(20),
  //           ),
  //         ),
  //         backgroundColor: Color(0xff347af0),
  //         duration: const Duration(seconds: 10),
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  Future<void> resendEmail() async {
    print('attempting to send verification email');
    try {
      await user!.sendEmailVerification();
      print("sent");
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: "Verification email sent",
            description: "",
          );
        },
      );
    } catch (error) {
      print("error sending verification error: $error");
      showDialog(
          barrierColor: Colors.black26,
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              title: "Verification email failed",
              description: "$error",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff347af0)),
          onPressed: () {
            // passing to the root page
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xffe0e9f8),
        // title: Center(
        //   child: Text(
        //     'Verifying your Email...',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xffe0e9f8),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/scan.png'),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Congratulations 👏',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          'You are one step closer \n in creating your account',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'An email has been sent to \n ${user!.email} \n \n please Verify your email',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xff347af0),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        FlatButton(
                          onPressed: resendEmail,
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
                              'Resend an Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
