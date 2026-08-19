import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        "Request failed : ${response.statusCode}",
      );
    }

    return jsonDecode(response.body);
  }
}
