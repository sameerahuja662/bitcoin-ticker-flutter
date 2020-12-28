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
  bool isWaiting =
      false; //Var for keeping track of when waiting for network requests.Shows placeholder text while waiting for network request data.

  void getCoinData() async {
    isWaiting = true; //Waiting for network request.
    try {
      var cryptoData = await CoinData().getCryptoRates(selectedCurrency);
      isWaiting =
          false; //Wait for network over after above code completes execution.
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
        title: Text('Crypto Coins'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCryptoCards(), //Returns Crypto card widgets for all currencies in crypto currencies list.
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

  Column makeCryptoCards() {
    List<CryptoCard> cryptoCards = [];
    for (String cryptoCurrency in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: cryptoCurrency,
          fiatValue:
              isWaiting ? '...' : cryptoFiatValues[cryptoCurrency].toString(),
          selectedCurrency: selectedCurrency,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
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

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.fiatValue,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String fiatValue;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoCurrency = $fiatValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
