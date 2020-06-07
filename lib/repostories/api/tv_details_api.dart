import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final String apiKey = '46cdbefa7013d9cd9c4027a799768019';

final apiUrl = 'https://api.themoviedb.org/3/tv/';

class TvDetailsAPI {
  Future<String> getTvDetails(String tvId) async {
    String fullURL = apiUrl + tvId + '?api_key=' + apiKey;

    final response = await http.get(fullURL);
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
