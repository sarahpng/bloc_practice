import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  Future<String> login(String email, String password) async {
    final body = {"email": email, "password": password};
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {
          'x-api-key': 'reqres-free-v1',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      // eve.holt@reqres.in
      // cityslicka
      if (response.statusCode == 200) {
        return response.body;
      }
    } on SocketException {
      throw ('Fetch error');
    }
    throw ('fetching error');
  }
}
