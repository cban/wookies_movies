import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  @JsonKey(name: 'movies')
  final List<Movie> movies;

   MoviesResponse({required this.movies});

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);
}
