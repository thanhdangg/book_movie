import 'package:dio/dio.dart';
import 'package:movie/configs/locator.dart';

class GenreRepository {
  final String _apiKey = '52fd990cf637355f51d3eea6bc930bba';
  final Dio dio = getIt<Dio>();

  Future<Map<int, String>> fetchGenres() async {
    try {
      final response = await dio.get(
        '/genre/movie/list',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> genres = response.data['genres'];
        return {for (var genre in genres) genre['id']: genre['name']};
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}