import 'package:bitcoin_ticker/Network.dart';
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'ADA',
  'SOL',
];

class CoinData {
  String frontUrl='https://rest.coinapi.io/v1/exchangerate';
  String apiKey='9B66EC90-0C6B-4E14-BE7C-B93EB1DB07BB';
  String coin='BTC',change='INR';
  //var rate=[];
  Map<String,String> price={};
  Future getCoinData(String change)async {

      for (String coin in cryptoList)
        {
          var coinData= await NetworkHelper('$frontUrl/$coin/$change?apikey=$apiKey').getData();
          //rate.add(coinData['rate']);
          print("$coin to $change ${coinData['rate']}");
          price[coin]=coinData['rate'].toStringAsFixed(0);
        }
      //print(price['ADA']);
      return price;
  }
}
