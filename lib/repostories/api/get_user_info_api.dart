import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class UserInfoAPI {
  Future<String> getUserInfo({String token}) async {
    String fullURL = 'http://tv-series-api.herokuapp.com/user/';

    final response = await http.post(fullURL,
        headers: {"Content-type": "application/json"},
        body: json.encode({
          'token': token,
        }));
    print(response.body);
    return (response.body);
  }
}
