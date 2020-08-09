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
  var cryptoFiatValues = {'BTC': 0.0, 'ETH': 0.0, 'LTC': 0.0};

  Future<Map<String, double>> getCryptoRates(
      String selectedFiatCurrency) async {
    for (String cryptoCurrency in cryptoList) {
      var requestURL =
          '$coinURL/$cryptoCurrency/$selectedFiatCurrency?apikey=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(requestURL);

      var coinData = await networkHelper.getData();
      print(coinData);
      if (coinData != null) {
        double result = coinData['rate'];
        cryptoFiatValues[cryptoCurrency] =
            double.parse(result.toStringAsFixed(3));
      } else {
        return null;
      }
    }
    return cryptoFiatValues;
  }
}
