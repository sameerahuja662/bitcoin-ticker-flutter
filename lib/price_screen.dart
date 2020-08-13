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
  Map<String, double> cryptoFiatValues = {};

  void getCoinData() async {
    try {
      var cryptoData = await CoinData().getCryptoRates(selectedCurrency);
      setState(() {
        cryptoFiatValues = cryptoData;
      });
    } catch (e) {
      print(e);
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
                  '1 BTC = ${cryptoFiatValues['BTC']} $selectedCurrency',
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
                  '1 ETH = ${cryptoFiatValues['ETH']} $selectedCurrency',
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
                  '1 LTC = ${cryptoFiatValues['LTC']} $selectedCurrency',
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

  // Android picker widget.
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
      onChanged: (value) {
        //Set newly changed currency as selected currency and call getCoinData() again.
        selectedCurrency = value;
        getCoinData();
      },
    );
  }

  // Ios picker widget.
  CupertinoPicker getIosPicker() {
    List<Text> currencyPickerList = [];

    for (String currency in currenciesList) {
      currencyPickerList.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        //Set newly changed currency as selected currency and call getCoinData() again.
        selectedCurrency = currenciesList[selectedIndex];
        getCoinData();
      },
      children: currencyPickerList,
    );
  }
}
