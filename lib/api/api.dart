import 'dart:convert';

import '../models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTk1YjYyOWZkNzdmNGQxYTMzZmYzNWNkNmFiODE2YyIsIm5iZiI6MTczNjM2NjE4OC4xODksInN1YiI6IjY3N2VkODZjYjExZDA4ODExMTdiMjE5OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vRjwBlS6B1ws6t6ZUHDarxLcKAMFuSkWhqH3vpZ4y0k';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((e) => Movie.fromMap(e)).toList();
      return movies;
    } else {
      throw Exception('Failed to get movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/top_rated'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((e) => Movie.fromMap(e)).toList();
      return movies;
    } else {
      throw Exception('Failed to get movies');
    }
  }

  static const imgPath = 'https://image.tmdb.org/t/p/original/';
}
