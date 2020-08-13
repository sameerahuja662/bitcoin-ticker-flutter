import 'networking.dart';

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
  'LTC',
];

const apiKey = '3D47FECD-6CF5-4907-86DB-78F07A6ADF1B';
const coinURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<Map<String, double>> getCryptoRates(
      String selectedFiatCurrency) async {
    //Empty Map for storing values.
    Map<String, double> cryptoFiatValues = {};

    //Loop through GET requests for all currencies in the list.
    for (String cryptoCurrency in cryptoList) {
      var requestURL =
          '$coinURL/$cryptoCurrency/$selectedFiatCurrency?apikey=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(requestURL);
      try {
        var coinData = await networkHelper.getData();
        print(coinData);

        double result = coinData['rate'];
        cryptoFiatValues[cryptoCurrency] =
            double.parse(result.toStringAsFixed(3));
      } catch (e) {
        throw e;
      }
    }
    return cryptoFiatValues;
  }
}
