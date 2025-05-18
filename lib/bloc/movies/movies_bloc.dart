import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wookies_movies/repository/movies_repository.dart';

import 'movies_event.dart';
import 'movies_state.dart';

@injectable
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository;

  MoviesBloc({required this.repository}) : super(MoviesInitial()) {
    on<GetMoviesEvent>(_onGetMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onGetMovies(
    GetMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(MoviesLoading());
    try {
      final response = await repository.getMovies();
      emit(MoviesLoaded(response.movies));
    } catch (e, stackTrace) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(MoviesLoading());
    try {
      final response = await repository.searchMovies(event.query);
      emit(MoviesLoaded(response.movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
