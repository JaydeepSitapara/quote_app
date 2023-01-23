import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<Map?> getQuote() async {

    print('method called');
    http.Response? response =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response == null) {
      print('no data found');
      return null;
    } else {
      print('get the data');
      return json.decode(response.body);
    }
  }
}
