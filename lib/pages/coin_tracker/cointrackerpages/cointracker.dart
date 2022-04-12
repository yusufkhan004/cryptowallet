// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/details_page.dart';
import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/coins.dart';
import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/favourites.dart';
import 'package:cryptowallet/pages/coin_tracker/models/cryptocurrency.dart';
import 'package:cryptowallet/pages/coin_tracker/provider/marketprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinTrackerScreen extends StatefulWidget {
  const CoinTrackerScreen({Key? key}) : super(key: key);

  @override
  State<CoinTrackerScreen> createState() => _CoinTrackerScreenState();
}

class _CoinTrackerScreenState extends State<CoinTrackerScreen>
    with SingleTickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Markets",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            )),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Welcome To,",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Realtime crypto price",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TabBar(
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text(
                      "Markets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favourites",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: viewController,
                  children: [
                    Coins(),
                    Favourites(),
                  ],
                ),
              )
              // Coins(),
              // Favourites(),
            ],
          ),
        ),
      ),
    );
  }
}
