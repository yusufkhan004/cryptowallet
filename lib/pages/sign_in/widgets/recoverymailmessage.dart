import 'package:cryptowallet/pages/sign_in/homescreen.dart';
import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class RecoveryMailMessage extends StatefulWidget {
  const RecoveryMailMessage({Key? key}) : super(key: key);

  @override
  State<RecoveryMailMessage> createState() => _RecoveryMailMessageState();
}

class _RecoveryMailMessageState extends State<RecoveryMailMessage> {
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
        title: Center(
          child: Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xffe0e9f8),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Receive an Email \n to  reset your password',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('assets/images/email.png', scale: 0.8),
                    Expanded(
                      child: Container(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()),
                                (route) => false);
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
                              'Reset Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
