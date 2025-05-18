import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wookies_movies/repository/movies_repository.dart';

import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MoviesRepository repository;

  MovieDetailBloc({required this.repository}) : super(MovieDetailInitial()) {
    on<GetMovieDetail>(_onGetMovieDetail);
  }

  Future<void> _onGetMovieDetail(
    GetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    try {
      final movie = await repository.getMovieById(event.id);
      if (movie != null) {
        emit(MovieDetailLoaded(movie));
      } else {
        emit(MovieDetailError('Movie not found'));
      }
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
