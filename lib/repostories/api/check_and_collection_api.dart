import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class CheckCollectionAndFavoriteApi {
  Future<bool> checkCollection({String userId, String tvId}) async {
    String fullURL =
        'http://tv-series-api.herokuapp.com/user/check/collection/' +
            userId +
            '/' +
            tvId;

    final response = await http.get(fullURL);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    }
  }

  Future<bool> checkFavorite({String userId, String tvId}) async {
    String fullURL = 'http://tv-series-api.herokuapp.com/user/check/favorite/' +
        userId +
        '/' +
        tvId;

    final response = await http.get(fullURL);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    }
  }
}
