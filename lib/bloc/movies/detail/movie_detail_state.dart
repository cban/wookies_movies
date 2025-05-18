import 'package:equatable/equatable.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;

  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
