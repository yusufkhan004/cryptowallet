// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/model/user_model.dart';
import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/coins.dart';
import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/cointracker.dart';
import 'package:cryptowallet/pages/home/homepage.dart';
import 'package:cryptowallet/pages/profile_body/profile.dart';
import 'package:cryptowallet/pages/sign_in/sign_in_page.dart';
import 'package:cryptowallet/pages/sign_in/widgets/navigate_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _currentIndex = 0;
  final List<Widget> tabs = [
    Center(child: Text("Home")),
    Center(child: Text("Markets")),
    Center(child: Text("Profile")),
  ];

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            HomePage(),
            CoinTrackerScreen(),
            Profile(),
            // NavigatorPage(
            //   child: Text('Profile', style: TextStyle(color: Colors.black)),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // iconSize: 20,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffe0e9f8),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Markets",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
