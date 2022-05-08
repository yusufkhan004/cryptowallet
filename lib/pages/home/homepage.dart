// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cryptowallet/pages/profile_body/profile.dart';
import 'package:cryptowallet/pages/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  // const HomePage({required this.child});
  // final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late Client httpClient;
  late Web3Client ethClient;
  final TextEditingController _formValue = TextEditingController();
  // int _AmountValue = int.parse(_formValue.text);
  bool data = false;
  final myAddress = "0x14D89f3A5D911021217E2fC1938C2d046DA9c279";
  late BigInt myData;
  late String txtHash;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(
        "https://rinkeby.infura.io/v3/e02feb089e614305b2a8467f7a298873",
        httpClient);
    getBalance(myAddress);
    // String txtHash;
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    // String contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
    String contractAddress = "0x6c8B78dDf4A4D58282A71B511fBcBa3B1B00ad25";

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'CWcoin'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    // EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);

    myData = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "3b3f3e473df9c345f30aa56777ee5f2b965a789bcb2d7f0ecb7d7b2921858b83");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    return result;
  }

  Future<String> sendCoin() async {
    var bigAmount = BigInt.from(int.parse(_formValue.text));
    print(_formValue.text);

    var response = await submit("depositBalance", [bigAmount]);

    print("Sended");
    txtHash = response;
    print(txtHash);
    setState(() {});
    return response;
  }

  Future<String> receiveCoin() async {
    var bigAmount = BigInt.from(int.parse(_formValue.text));

    var response = await submit("withDrawBalance", [bigAmount]);

    print("Received");
    txtHash = response;
    print(txtHash);
    setState(() {});
    return response; //transacration hash
  }

  User? mainUser = FirebaseAuth.instance.currentUser;

  Future<firestore.DocumentSnapshot> getUserInfo() async {
    return await firestore.FirebaseFirestore.instance
        .collection("users")
        .doc(mainUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return RefreshIndicator(
                onRefresh: () async {
                  await getBalance(myAddress);
                },
                child: Scaffold(
                  backgroundColor: Color(0xff347af0),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Welcome,",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xffe0e9f8)),
                                  ),
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
                                          // SizedBox(
                                          //   height: 1,
                                          // ),
                                          FutureBuilder(
                                            future: getUserInfo(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        firestore
                                                            .DocumentSnapshot>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return Container(
                                                  height: 37,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffe0e9f8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return Profile();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!["name"],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 19,
                                                            color:
                                                                // Color(0xff347af0),
                                                                Colors.black,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          constraints:
                                                              BoxConstraints(),
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down_rounded,
                                                            color:
                                                                // Color(0xff347af0),
                                                                Colors.black,
                                                            size: 28.0,
                                                          ),
                                                          onPressed: () {},
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.none) {
                                                return Text("No User");
                                              }
                                              return CircularProgressIndicator();
                                            },
                                          ),
                                        ],
                                      )),
                                      Container(
                                        width: 35,
                                        decoration: new BoxDecoration(
                                          color: Color(0xffe0e9f8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          // constraints: BoxConstraints(),
                                          icon: new Icon(Icons.settings,
                                              color: Colors.black, size: 26.0),
                                          // highlightColor: Colors.white,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return SettingsScreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(25.0)),
                                      gradient: new LinearGradient(
                                          colors: [
                                            Color(0xffadd8e6),
                                            Color(0xffe0e9f8),
                                            // Color(0xfff9957f),
                                            // Color(0xfff2f5d0),
                                            // Color(0xff2eaafa),
                                            // Color(0xff8c04db),
                                            // Color(0xff347af0)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.clamp)),

                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  // padding: EdgeInsets.all(20),
                                  width:
                                      MediaQuery.of(context).size.width * 1.0,
                                  height: 170,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "CWCOIN",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Total Balance",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      data
                                          ? new Text(
                                              "￠" + myData.toString(),
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          : CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.black),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // color: Color(0xff347af0),
                                      // borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                      ),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  height:
                                      MediaQuery.of(context).size.width * 1.0,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                    bottom: 50,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: new TextFormField(
                                          decoration: new InputDecoration(
                                              labelText: "Amount"),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          controller: _formValue,
                                          onSaved: (value) {
                                            _formValue.text = value!;
                                            print(_formValue.text);
                                            print("//*******/");
                                            print(int.parse(_formValue.text));
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // new ElevatedButton(
                                          //   // child: new Text("Refresh"),
                                          //   onPressed: () {
                                          //     getBalance(myAddress);
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //     primary: Colors.blue,
                                          //   ),
                                          //   child: Wrap(
                                          //     children: <Widget>[
                                          //       Icon(
                                          //         Icons.refresh_rounded,
                                          //         color: Colors.white,
                                          //         // size: 24.0,
                                          //       ),
                                          //       SizedBox(
                                          //         width: 5,
                                          //       ),
                                          //       Text("Refresh",
                                          //           style: TextStyle(
                                          //               fontSize: 18,
                                          //               fontWeight:
                                          //                   FontWeight.w400)),
                                          //     ],
                                          //   ),
                                          // ),

                                          new ElevatedButton(
                                            onPressed: () {
                                              receiveCoin();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xffe0e9f8)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .arrowAltCircleUp,
                                                      color: Colors.black,
                                                      size: 24.0,
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text("Send",
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        )),
                                                    // SizedBox(height: 20),
                                                    // Container(
                                                    //   height: 50,
                                                    //   decoration: BoxDecoration(
                                                    //       color:
                                                    //           Color(0xffe0e9f8),
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(20),
                                                    //       shape: BoxShape
                                                    //           .rectangle,
                                                    //       boxShadow: [
                                                    //         BoxShadow(
                                                    //           color:
                                                    //               Colors.grey,
                                                    //           blurRadius: 3.0,
                                                    //         ),
                                                    //       ]),
                                                    //   margin: EdgeInsets.only(
                                                    //       left: 15, right: 15),
                                                    //   // padding: EdgeInsets.all(20),
                                                    //   width:
                                                    //       MediaQuery.of(context)
                                                    //               .size
                                                    //               .width *
                                                    //           1.0,

                                                    //   child: Row(
                                                    //     children: [
                                                    //       Expanded(
                                                    //         child: Center(
                                                    //           child: Text(
                                                    //             txtHash,
                                                    //             style:
                                                    //                 TextStyle(
                                                    //               fontSize: 18,
                                                    //               height: 1.4,
                                                    //               color: Colors
                                                    //                   .black,
                                                    //               // fontWeight: FontWeight.bold,
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          new ElevatedButton(
                                            onPressed: () {
                                              sendCoin();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffe0e9f8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .arrowAltCircleDown,
                                                      color: Colors.black,
                                                      size: 24.0,
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text("Receive",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
    });
  }
}
// Icons.settings