import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class RegisterAPI {
  Future<http.Response> createNewUser(
      {String username,
      String email,
      String password,
      String confirmPassword}) async {
    String fullURL = 'http://tv-series-api.herokuapp.com/user/signup';

    final response = await http.post(fullURL,
        headers: {"Content-type": "application/json"},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        }));
    print(response.body);
    return response;
  }
}
