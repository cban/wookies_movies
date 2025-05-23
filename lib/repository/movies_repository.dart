import 'package:injectable/injectable.dart';
import 'package:wookies_movies/data/local/shared_pref_data.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:wookies_movies/data/remote/api_service.dart';

import '../data/model/movies/movie.dart';

@injectable
class MoviesRepository {
  final ApiService _apiService;
  final SharedPrefData _cachedData;

  MoviesRepository(this._apiService, this._cachedData);

  Future<MoviesResponse> getMovies() async {
    final cachedMovies = await _cachedData.getCachedMovies();
    if (cachedMovies != null) {
      return cachedMovies;
    } else {
      final moviesResponse = await _apiService.getMovies();
      await _cachedData.cacheMovies(moviesResponse);
      return moviesResponse;
    }
  }

  Future<Movie?> getMovieById(String id) async {
    final cachedMovies = await _cachedData.getCachedMovies();
    if (cachedMovies != null) {
      return cachedMovies.movies.firstWhere((movie) => movie.id == id);
    } else {
      final moviesResponse = await _apiService.getMovies();
      await _cachedData.cacheMovies(moviesResponse);
      return moviesResponse.movies.firstWhere((movie) => movie.id == id);
    }
  }

  Future<MoviesResponse> searchMovies(String query) =>
      _apiService.searchMovies(query);
}
