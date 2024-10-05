import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {  
  const factory Movie(
      {required int id,
      required String title,
      required String overview,
      required String posterPath,
      required String backdropPath,
      required String releaseDate,
      required double voteAverage,
      required int voteCount,
      required String originalLanguage,
      required double popularity,
      required List<int> genreIds}) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      backdropPath: json['backdrop_path'] ?? '',
      originalLanguage: json['original_language'] ?? 'Unknown',
      popularity: json['popularity'] ?? 0.0,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }
}
