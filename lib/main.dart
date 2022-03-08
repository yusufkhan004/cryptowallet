// ignore_for_file: prefer_const_constructors

// import 'package:cryptowallet/livecryptostream/services/ably_services.dart';
// import 'package:cryptowallet/livecryptostream/view/dashboard.dart';
import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:cryptowallet/pages/sign_up/widgets/email_verification.dart';
import 'package:cryptowallet/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // getIt.registerSingletonAsync<AblyService>(() => AblyService.init());
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
      theme: ThemeData(fontFamily: 'Titillium'),
      // home: WelcomePage(),
      home: SignInPage(),
      // home: EmailVerification(),
      // home: EmailVerification(),
      // home: DashboardView(),
      // home: SignInPage(),
    );
  }
}
