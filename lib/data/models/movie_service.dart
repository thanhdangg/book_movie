import 'package:dio/dio.dart';
import 'package:movie/data/models/movie.dart';

class MovieService {
  final Dio _dio;

  MovieService(this._dio);

  Future<List<Movie>> getPopularMovies() async {
    final response = await _dio.get(
      '/movie/popular',
      queryParameters: {
        'api_key': '52fd990cf637355f51d3eea6bc930bba',
        'language': 'en-US',
        'page': 1,
      },
    );
    
    return (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }
}
