import 'package:cryptowallet/pages/coin_tracker/cointrackerpages/details_page.dart';
import 'package:cryptowallet/pages/coin_tracker/models/cryptocurrency.dart';
import 'package:cryptowallet/pages/coin_tracker/provider/marketprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({Key? key, required this.currentCrypto}) : super(key: key);
  final CryptoCurrency currentCrypto;

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(id: currentCrypto.id!)),
        );
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(currentCrypto.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavourite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavourite(currentCrypto);
                  },
                  child: const Icon(CupertinoIcons.heart, size: 18),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
            style: const TextStyle(
                color: const Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;

            if (priceChange < 0) {
              //negative price
              return Text(
                  "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold));
            } else {
              // positive
              return Text(
                  "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold));
            }
          }),
        ],
      ),
    );
  }
}
