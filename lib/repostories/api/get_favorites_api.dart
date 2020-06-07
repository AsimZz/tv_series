import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class GetListOfFavoritesApi {
  Future<String> getListOfFavorites({String userId}) async {
    String fullURL =
        'http://tv-series-api.herokuapp.com/user/favorite/' + userId;

    final response = await http.get(fullURL);
    print(response.body);
    return (response.body);
  }
}
