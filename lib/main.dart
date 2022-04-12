// ignore_for_file: prefer_const_constructors

import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/cointracker.dart';
// import 'package:cryptowallet/pages/coin_tracker/constants/Themes.dart';
import 'package:cryptowallet/pages/coin_tracker/provider/marketprovider.dart';
import 'package:cryptowallet/pages/home/homepage.dart';
// import 'package:cryptowallet/pages/profile_body/pages/edit_name.dart';
import 'package:cryptowallet/pages/profile_body/profile.dart';
// import 'package:cryptowallet/pages/settings/settings_screen.dart';
import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
// import 'package:cryptowallet/pages/sign_up/widgets/email_verification.dart';
// import 'package:cryptowallet/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'pages/sign_in/homescreen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Titillium',
          scaffoldBackgroundColor: Colors.white,
        ),
        // home: WelcomePage(),
        home: SignInPage(),
        // home: HomePage(),

        // home: EmailVerification(),
        // home: DashboardView(),
        // home: CoinTrackerScreen(),
        // home: HomeScreen(),
        // home: Profile(),
        // home: EditNameFormPage(),
        // home:SettingsScreen(),
      ),
    );

    // );
  }
}
