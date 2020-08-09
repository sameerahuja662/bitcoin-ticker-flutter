import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  double btcFiatRate = 0;
  double ethFiatRate = 0;
  double ltcFiatRate = 0;
  CoinData coinData = CoinData();

  void getCoinData() async {
    Map<String, double> fiatRates =
        await coinData.getCryptoRates(selectedCurrency);
    if (fiatRates != null) {
      setState(() {
        btcFiatRate = fiatRates['BTC'];
        ethFiatRate = fiatRates['ETH'];
        ltcFiatRate = fiatRates['LTC'];
      });
    } else {
      print('Print Network error');
    }
  }

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $btcFiatRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 ETH = $ethFiatRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 LTC = $ltcFiatRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //Get Platform specific menu
            child: Platform.isIOS ? getIosPicker() : getAndroidPicker(),
          ),
        ],
      ),
    );
  }

  DropdownButton getAndroidPicker() {
    //Prepare List of currencies for DropDownMenu.
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    for (String currency in currenciesList) {
      //Initialise new dropDownMenuItem items.
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      //Add menu items to the list.
      dropDownMenuItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenuItems,
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
        });
        Map<String, double> fiatRates =
            await coinData.getCryptoRates(selectedCurrency);
        setState(() {
          btcFiatRate = fiatRates['BTC'];
          ethFiatRate = fiatRates['ETH'];
          ltcFiatRate = fiatRates['LTC'];
        });
      },
    );
  }

  CupertinoPicker getIosPicker() {
    List<Text> currencyPickerList = [];

    for (String currency in currenciesList) {
      currencyPickerList.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        Map<String, double> fiatRates =
            await coinData.getCryptoRates(selectedCurrency);
        setState(() {
          btcFiatRate = fiatRates['BTC'];
          ethFiatRate = fiatRates['ETH'];
          ltcFiatRate = fiatRates['LTC'];
        });
      },
      children: currencyPickerList,
    );
  }
}

/*

items: [
DropdownMenuItem(
child: Text('USD'),
value: 'USD',
),
DropdownMenuItem(
child: Text('EUR'),
value: 'EUR',
),
DropdownMenuItem(
child: Text('GBP'),
value: 'GBP',
),
DropdownMenuItem(
child: Text('INR'),
value: 'INR',
),
],*/

/*

currenciesList.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),*/

/*
DropdownButton<String>(
value: selectedCurrency,
items:
,
onChanged: (value) {
setState(() {
selectedCurrency = value;
});
},
)*/

/*//Prepare List of currencies for DropDownMenu.
  List<DropdownMenuItem> getCurrencyItems() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    for (String currency in currenciesList) {
      //Initialise new dropDownMenuItem items.
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      //Add menu items to the list.
      dropDownMenuItems.add(newItem);
    }

    return dropDownMenuItems;
  }*/

/*List<Text> getPickerItems() {
    List<Text> currencyPickerList = [];

    for (String currency in currenciesList) {
      currencyPickerList.add(Text(currency));
    }
    return currencyPickerList;
  }*/
