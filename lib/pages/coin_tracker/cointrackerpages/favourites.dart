import 'package:cryptowallet/pages/coin_tracker/models/cryptocurrency.dart';
import 'package:cryptowallet/pages/coin_tracker/provider/marketprovider.dart';
import 'package:cryptowallet/pages/coin_tracker/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favourites = marketProvider.markets
            .where((element) => element.isFavourite == true)
            .toList();

        if (favourites.length > 0) {
          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = favourites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return Center(
            child: Text(
              "No favourites exist",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
    // return Container(
    //   child: Text("Favourite wil show up here"),
    // );
  }
}
