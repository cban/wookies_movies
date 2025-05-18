import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEvent {}

class SearchMoviesEvent extends MoviesEvent {
  final String query;

  SearchMoviesEvent(this.query);

  @override
  List<Object> get props => [query];
}
class GetMovieByIdEvent extends MoviesEvent {
  final String id;

  GetMovieByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}