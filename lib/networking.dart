import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Network Error, Status Code: ${response.statusCode}');
      throw ('Error with the GET request');
    }
  }
}
