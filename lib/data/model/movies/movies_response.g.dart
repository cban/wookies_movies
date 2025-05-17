// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesResponse _$MoviesResponseFromJson(Map<String, dynamic> json) =>
    MoviesResponse(
      movies:
          (json['movies'] as List<dynamic>)
              .map((e) => Movie.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MoviesResponseToJson(MoviesResponse instance) =>
    <String, dynamic>{'movies': instance.movies};
