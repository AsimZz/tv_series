import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class GetListOfCollectionsApi {
  Future<String> getListOfCollections({String userId}) async {
    String fullURL = 'http://tv-series-api.herokuapp.com/user/collection/' + userId;
    
    final response = await http.get(fullURL);
    print(response.body);
    return (response.body);
  }
}
