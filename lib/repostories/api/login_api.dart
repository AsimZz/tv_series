import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class LoginAPI {
  Future<http.Response> logInUser({String email, String password}) async {
    String fullURL = 'http://tv-series-api.herokuapp.com/user/login';

    final response = await http.post(fullURL,
        headers: {"Content-type": "application/json"},
        body: json.encode({
          'email': email,
          'password': password,
        }));
    print(response);
    return (response);
  }
}
