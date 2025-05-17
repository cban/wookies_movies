// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  backdrop: json['backdrop'] as String,
  cast: (json['cast'] as List<dynamic>).map((e) => e as String).toList(),
  classification: json['classification'] as String,
  director: Movie._directorFromJson(json['director']),
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
  id: json['id'] as String,
  imdbRating: (json['imdb_rating'] as num).toDouble(),
  length: json['length'] as String,
  overview: json['overview'] as String,
  poster: json['poster'] as String,
  releasedOn: json['released_on'] as String,
  slug: json['slug'] as String,
  title: json['title'] as String,
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'backdrop': instance.backdrop,
  'cast': instance.cast,
  'classification': instance.classification,
  'director': instance.director,
  'genres': instance.genres,
  'id': instance.id,
  'imdb_rating': instance.imdbRating,
  'length': instance.length,
  'overview': instance.overview,
  'poster': instance.poster,
  'released_on': instance.releasedOn,
  'slug': instance.slug,
  'title': instance.title,
};
