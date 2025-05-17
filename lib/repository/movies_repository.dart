import 'package:injectable/injectable.dart';
import 'package:wookies_movies/data/remote/api_service.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';

@injectable
class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository(this._apiService);

  Future<MoviesResponse> getMovies() => _apiService.getMovies();

  Future<MoviesResponse> searchMovies(String query) => _apiService.searchMovies(query);
}