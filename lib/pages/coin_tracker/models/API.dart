// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  //adding static to method allows to call the method inside the class without creating any instance of class
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=15&page=1&sparkline=false");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      // print(markets);
      return markets;
    } catch (ex) {
      return [];
    }
  }
}
