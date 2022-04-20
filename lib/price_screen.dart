import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency="INR";
  String coin="BTC";

  Map<String,String> rate={};
  bool isWaiting=false;
  Widget androidDropper()
  {

    List <DropdownMenuItem<String>> dropdownItems=[];
            for(int i=0;i<currenciesList.length;i++)
        {
          String currency = currenciesList[i];
          dropdownItems.add(DropdownMenuItem(child: Text(currency,),value:currency ));
      }
    return  DropdownButton<String>(
      items: dropdownItems,
      value: selectedCurrency,
      onChanged: (value){
        setState(() {
          selectedCurrency=value;
          getCoin();
        });
      },
    );
  }
  CupertinoPicker iosPicker()
  {
    List<Text> picker=[];
    for (String i in currenciesList)
      {
        picker.add(Text(i));
      }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children:picker ,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency=currenciesList[selectedIndex];
          getCoin();
          print(selectedCurrency);
        });
      },
    );
  }
  void getCoin() async {
    try {
        isWaiting=true;
        rate = await CoinData().getCoinData(selectedCurrency);
        setState(()  {
          rate = rate;
          print('rate1 = ${rate['BTC']}');
        });
        isWaiting=false;
        }
    catch(e)
    {
      print(e);
    }
  }
  
  List<Widget> getCoinCard()
  {
    List<Widget> coinCard=[];

    for(String coin in cryptoList) {

      print("rate2 = ${rate[coin]}");
      coinCard.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $coin = ${rate[coin]} $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    return coinCard;
  }

@override
  void initState() {
    // TODO: implement initState
      super.initState();
      getCoin();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑Crypto Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: getCoinCard(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosPicker(),
          ),
        ],
      ),
    );
  }
}
// Platform.isAndroid? androidDropper():iosPicker()