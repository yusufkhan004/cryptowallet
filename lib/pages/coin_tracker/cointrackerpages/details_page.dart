// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cryptowallet/pages/coin_tracker/models/cryptocurrency.dart';
import 'package:cryptowallet/pages/coin_tracker/provider/marketprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      Text(detail, style: TextStyle(fontSize: 17)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe0e9f8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffe0e9f8),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(
                        currentCrypto.name! +
                            "(${currentCrypto.symbol!.toUpperCase()})",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "₹" + currentCrypto.currentPrice.toString(),
                        style: TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Change (24h)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Builder(builder: (context) {
                          double priceChange = currentCrypto.priceChange24!;
                          double priceChangePercentage =
                              currentCrypto.priceChangePercentage24!;

                          if (priceChange < 0) {
                            //negative price
                            return Text(
                                "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 23));
                          } else {
                            // positive
                            return Text(
                                "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 23));
                          }
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Market Cap",
                            "₹ " + currentCrypto.marketCap!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "Market Cap Rank",
                            "# " + currentCrypto.marketCapRank!.toString(),
                            CrossAxisAlignment.end),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Low 24h",
                            "₹ " + currentCrypto.low24!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "High 24h",
                            "₹ " + currentCrypto.high24!.toStringAsFixed(4),
                            CrossAxisAlignment.end),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Circulating Supply",
                            currentCrypto.circulatingSupply!.toInt().toString(),
                            CrossAxisAlignment.start),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "All Time Low",
                            currentCrypto.atl!.toInt().toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "All Time High",
                            currentCrypto.ath!.toInt().toStringAsFixed(4),
                            CrossAxisAlignment.start),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
