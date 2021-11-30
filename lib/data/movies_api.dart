import 'dart:convert';

import 'package:http/http.dart';

class MoviesApi {
  Future<List<String>> getMovies(int page) async {
    final Uri uri = Uri(scheme: 'https', host: 'yts.mx', pathSegments: <String>[
      'api',
      'v2',
      'list_movies.json'
    ], queryParameters: {
      'limit': '50',
      'page': '$page',
      'sort_by': 'year',
      'order_by': 'desc',
      'quality': '720p',
      'minimum_rating': '7'
    });

    final Response response = await get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final Map<String, dynamic> data = body['data'] as Map<String, dynamic>;
      final List<dynamic> movies = data['movies'];
      return movies.map((dynamic movie) => movie['title'] as String).toList();
    } else {
      return throw StateError('Error fetching the movies.');
    }
  }
}
