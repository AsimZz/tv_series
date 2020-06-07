import 'package:tv_series/UIs/list_tv.dart';
import 'package:tv_series/repostories/api/tv_details_api.dart';

import 'package:tv_series/repostories/models/tv_details.dart';

import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

final r = new Random();

class ListTv {
  String imageUrl;
  String title;
  String id;

  ListTv({
    this.imageUrl,
    this.title,
    this.id,
  });
}

TvDetailsAPI tv_api;
final String apiKey = '3dea7c8e2dc24cbe8d847a907db2c098';

final apiUrl = 'https://api.themoviedb.org/3/tv/';
Future<List<String>> getImageUrl(String id) async {
  String fullURL = apiUrl + id + '?api_key=' + apiKey;

  final response = await http.get(fullURL);
  TvDetails tvD;
  if (response.statusCode == 200) {
    print(response.body);
    var jsonData = json.decode(response.body);

    tvD = TvDetails.fromJson(jsonData);
  }
  return [tvD.backdropPath, tvD.originalName];
}

final List<String> labels = [
  'Discover',
  'Categories',
  'Specials',
  'New',
];

final List<ListTv> popular = [
  ListTv(
      id: '87108',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/uL6Ad12W09L1sfuOE2pcTeak7bt.jpg',
      title: 'Chernobyl'),
  ListTv(
      id: '1396',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg',
      title: 'Breaking Bad'),
  ListTv(
      id: '1399',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
      title: 'Game of Thrones'),
  ListTv(
      id: '1438',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/oggnxmvofLtGQvXsO9bAFyCj3p6.jpg',
      title: 'The Wire'),
  ListTv(
      id: 'c',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/xGexTKCJDkl12dTW4YCBDXWb1AD.jpg',
      title: 'La casa de papel'),
  ListTv(
      id: '60625',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/eV3XnUul4UfIivz3kxgeIozeo50.jpg',
      title: 'Rick and Morty'),
  ListTv(
      id: '66732',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
      title: 'Stranger Things'),
  ListTv(
      id: '60574',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/1c5wA3y9K8WRwQRcU8oGFRNJ7Yn.jpg',
      title: 'Peaky Blinders'),
  ListTv(
      id: '2316',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/vNpuAxGTl9HsUbHqam3E9CzqCvX.jpg',
      title: 'The Office'),
  ListTv(
      id: '46648',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/2Ahm0YjLNQKuzSf9LOkHrXk8qIE.jpg',
      title: 'True Detective'),
  ListTv(
      id: '799',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/ilsEvD8iyyZmq0uSXpD97r8GE1Q.jpg',
      title: 'Sherlock'),
];

final List<ListTv> favorites = [];
final r_id = r.nextInt(70000).toString();
