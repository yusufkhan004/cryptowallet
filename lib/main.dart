// ignore_for_file: prefer_const_constructors

import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:cryptowallet/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Raleway'),
      // home: WelcomePage(),
      home: SignInPage(),
      // home: SignInPage(),
    );
  }
}
