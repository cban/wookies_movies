import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:injectable/injectable.dart';
part 'api_service.g.dart';

@singleton
@RestApi(baseUrl: 'https://wookie.codesubmit.io')
abstract class ApiService {

  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;


  @GET("/movies")
  Future<MoviesResponse> getMovies();

  @GET("/movies")
  Future<MoviesResponse> searchMovies(@Query("q") String query);
}
