import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final String apiKey = '46cdbefa7013d9cd9c4027a799768019';

final apiUrl =
    'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&language=en-US&page=1&include_adult=true&query=';

class TvAPI {
  Future<String> searchTvSeries(String tvName) async {
    String fullURL = apiUrl + tvName;

    final response = await http.get(fullURL);
    if (response.statusCode == 200) {
      // print(response.body);
      return response.body;
    }
  }
}
