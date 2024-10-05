import 'package:flutter/material.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/configs/locator.dart';

class MovieRepository {
  final String _apiKey = '52fd990cf637355f51d3eea6bc930bba';
  // final GenreRepository genreRepository = getIt<GenreRepository>();

  Future<List<Movie>> fetchPopularMovies() async {
    try {
      // final genreMap = await genreRepository.fetchGenres();
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        debugPrint("====response success: ${response.data}");
        return results.map((json) => Movie.fromJson(json)).toList();
        // return results.map((json) {
        //   debugPrint("====parsing movie: $json");
        //   final movie = Movie.fromJson(json);
        //   // final genreNames = movie.getGenreNames(genreMap);
        //   debugPrint("====genre names: $genreNames");
        //   debugPrint("====movie after map: $movie");
        //   return movie;
        // }).toList();
      } else {
        debugPrint("====response failed: ${response.data}");
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      debugPrint("====error: $e");
      throw Exception('Failed to fetch popular movies: $e');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top-rated movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch top-rated movies: $e');
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch upcoming movies: $e');
    }
  }

  Future<List<Movie>> fetchMoviesByCategory(String category) async {
    try {
      final response = await dio.get(
        '/movie/$category',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies by category');
      }
    } catch (e) {
      throw Exception('Failed to fetch movies by category: $e');
    }
  }
}
