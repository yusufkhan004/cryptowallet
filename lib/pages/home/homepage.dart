// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({required this.child});
  // final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textEditingController;
  int _currentRoute = 0;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              // backgroundColor: appBgColor,
              body: Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xffe0e9f8),
                  ),
                  new Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment
                        //         .bottomRight, // 10% of the width, so there are ten blinds.
                        //     colors: <Color>[
                        //       Color(0xff91b7f8),
                        //       Color(0xff6da0f5),
                        //       Color(0xff4e8cf4),
                        //       Color(0xff4083f5),
                        //       Color(0xff347af0),
                        //       Color(0xff005cf7),
                        //     ],
                        //   ),
                        // ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Welcome,",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            "Sangvaleap V",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: Color(0xff347af0),
                                            ),
                                          ),
                                        ],
                                      )),
                                      IconButton(
                                        icon: new Icon(Icons.settings,
                                            color: Color(0xff347af0),
                                            size: 27.0),
                                        // highlightColor: Colors.white,
                                        onPressed: () {
                                          // _onSearchButtonPressed();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    // color: Color(0xff6da0f5),
                                    color: Color(0xff347af0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Balance",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      //   SizedBox(
                                      //     height: 5,
                                      //   ),
                                      //   Text(
                                      //     "balance",
                                      //     maxLines: 1,
                                      //     overflow: TextOverflow.fade,
                                      //     style: TextStyle(
                                      //         fontSize: 18,
                                      //         fontWeight: FontWeight.w600),
                                      //   ),
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             "Monthly profit",
                                      //             style: TextStyle(
                                      //                 fontSize: 12,
                                      //                 fontWeight:
                                      //                     FontWeight.w400),
                                      //           ),
                                      //           SizedBox(
                                      //             height: 5,
                                      //           ),
                                      //           Text(
                                      //             "profit",
                                      //             maxLines: 1,
                                      //             overflow: TextOverflow.fade,
                                      //             style: TextStyle(
                                      //                 fontSize: 15,
                                      //                 fontWeight:
                                      //                     FontWeight.w600),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       Container(
                                      //         padding: EdgeInsets.only(
                                      //             left: 3, right: 3),
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.white
                                      //                 .withOpacity(.2),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     30)),
                                      //         child: Row(
                                      //           children: [
                                      //             Icon(Icons
                                      //                 .arrow_drop_up_sharp),
                                      //             Text(
                                      //               "change",
                                      //               style: TextStyle(
                                      //                 fontSize: 10,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                    bottom: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          });
    });
  }
}
// Icons.settings