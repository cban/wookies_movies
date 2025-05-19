import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wookies_movies/bloc/movies/detail/movie_detail_bloc.dart';
import 'package:wookies_movies/bloc/movies/detail/movie_detail_event.dart';
import 'package:wookies_movies/bloc/movies/detail/movie_detail_state.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';
import 'package:wookies_movies/repository/movies_repository.dart';

@GenerateMocks([MoviesRepository])
import 'movie_detail_bloc_test.mocks.dart';

void main() {
  late MockMoviesRepository mockRepository;
  late MovieDetailBloc subjectUnderTest;

  setUp(() {
    mockRepository = MockMoviesRepository();
    subjectUnderTest = MovieDetailBloc(repository: mockRepository);
  });

  tearDown(() {
    subjectUnderTest.close();
  });

  group('GetMovieDetail', () {
    final movieId = "test-id-123";
    final testMovie = Movie(
      id: movieId,
      title: "Test Movie",
      overview: "Test Overview",
      backdrop: "backdrop.jpg",
      poster: "poster.jpg",
      imdbRating: 8.5,
      length: "2h",
      director: "Test Director",
      classification: "PG",
      releasedOn: "2022-01-01",
      slug: "test-movie",
      cast: ["Actor 1", "Actor 2"],
      genres: ["Action", "Drama"],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [MovieDetailLoading, MovieDetailLoaded] when GetMovieDetail is added and movie is found',
      build: () {
        when(
          mockRepository.getMovieById(movieId),
        ).thenAnswer((_) async => testMovie);
        return subjectUnderTest;
      },
      act: (bloc) => bloc.add(GetMovieDetail(movieId)),
      expect:
          () => [
            isA<MovieDetailLoading>(),
            isA<MovieDetailLoaded>().having(
              (state) => state.movie,
              'movie',
              testMovie,
            ),
          ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [MovieDetailLoading, MovieDetailError] when GetMovieDetail is added and movie is not found',
      build: () {
        when(
          mockRepository.getMovieById(movieId),
        ).thenAnswer((_) async => null);
        return subjectUnderTest;
      },
      act: (bloc) => bloc.add(GetMovieDetail(movieId)),
      expect:
          () => [
            isA<MovieDetailLoading>(),
            isA<MovieDetailError>().having(
              (state) => state.message,
              'error message',
              'Movie not found',
            ),
          ],
    );
  });
}
