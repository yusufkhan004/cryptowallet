import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:cryptowallet/pages/welcome_page.dart';
import 'package:cryptowallet/injection.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
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
