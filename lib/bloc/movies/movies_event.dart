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