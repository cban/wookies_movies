import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';
@JsonSerializable()
class Movie {
  final String backdrop;
  final List<String> cast;
  final String classification;

  @JsonKey(fromJson: _directorFromJson)
  final String director;
  final List<String> genres;
  final String id;
  @JsonKey(name: 'imdb_rating')
  final double imdbRating;
  final String length;
  final String overview;
  final String poster;
  @JsonKey(name: 'released_on')
  final String releasedOn;
  final String slug;
  final String title;

  Movie({
    required this.backdrop,
    required this.cast,
    required this.classification,
    required this.director,
    required this.genres,
    required this.id,
    required this.imdbRating,
    required this.length,
    required this.overview,
    required this.poster,
    required this.releasedOn,
    required this.slug,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static String _directorFromJson(dynamic value) {
    if (value is List) {
      return value.join(", ");
    }
    return value as String;
  }
}




