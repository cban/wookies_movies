import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wookies_movies/bloc/movies/movies_bloc.dart';
import 'package:wookies_movies/bloc/movies/movies_event.dart';
import 'package:wookies_movies/bloc/movies/movies_state.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:wookies_movies/repository/movies_repository.dart';

@GenerateMocks([MoviesRepository])
import 'movies_bloc_test.mocks.dart';

void main() {
  late MockMoviesRepository mockRepository;
  late MoviesBloc moviesBloc;

  setUp(() {
    mockRepository = MockMoviesRepository();
    moviesBloc = MoviesBloc(repository: mockRepository);
  });

  test('initial state is MoviesInitial', () {
    expect(moviesBloc.state, isA<MoviesInitial>());
  });

  group('GetMoviesEvent', () {
    final movies = [
      Movie(
        id: "1",
        title: "Test Movie",
        overview: "Overview",
        backdrop: "backdrop.jpg",
        poster: "poster.jpg",
        imdbRating: 8.5,
        length: "2h",
        director: "Director",
        classification: "PG",
        releasedOn: "2020-01-01",
        slug: "test-movie",
        cast: ["Actor 1"],
        genres: ["Action"],
      ),
    ];

    final moviesResponse = MoviesResponse(movies: movies);

    blocTest<MoviesBloc, MoviesState>(
      'emits [MoviesLoading, MoviesLoaded] when GetMoviesEvent is added and API call is successful ',
      build: () {
        when(
          mockRepository.getMovies(),
        ).thenAnswer((_) async => moviesResponse);
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GetMoviesEvent()),
      expect:
          () => [
            isA<MoviesLoading>(),
            isA<MoviesLoaded>().having(
              (state) => state.movies,
              'movies',
              movies,
            ),
          ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [MoviesLoading, MoviesError] when GetMoviesEvent is added and API call fails',
      build: () {
        when(
          mockRepository.getMovies(),
        ).thenThrow(Exception('Failed to fetch movies'));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GetMoviesEvent()),
      expect:
          () => [
            isA<MoviesLoading>(),
            isA<MoviesError>().having(
              (state) => state.message,
              'error message',
              contains('Failed to fetch movies'),
            ),
          ],
    );
  });

  group('SearchMoviesEvent', () {
    final query = 'Star Wars';
    final searchResults = [
      Movie(
        id: "2",
        title: "Star Wars",
        overview: "A long time ago...",
        backdrop: "backdrop.jpg",
        poster: "poster.jpg",
        imdbRating: 9.0,
        length: "2h 30m",
        director: "George Lucas",
        classification: "PG",
        releasedOn: "1977-05-25",
        slug: "star-wars",
        cast: ["Mark Hamill", "Harrison Ford"],
        genres: ["Sci-Fi", "Action"],
      ),
    ];

    final searchResponse = MoviesResponse(movies: searchResults);

    blocTest<MoviesBloc, MoviesState>(
      'emits [MoviesLoading, MoviesLoaded] when SearchMoviesEvent is added and search succeeds',
      build: () {
        when(
          mockRepository.searchMovies(query),
        ).thenAnswer((_) async => searchResponse);
        return moviesBloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent(query)),
      expect:
          () => [
            isA<MoviesLoading>(),
            isA<MoviesLoaded>().having(
              (state) => state.movies,
              'movies',
              searchResults,
            ),
          ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [MoviesLoading, MoviesError] when SearchMoviesEvent is added and search fails',
      build: () {
        when(
          mockRepository.searchMovies(query),
        ).thenThrow(Exception('Search failed'));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent(query)),
      expect:
          () => [
            isA<MoviesLoading>(),
            isA<MoviesError>().having(
              (state) => state.message,
              'error message',
              contains('Search failed'),
            ),
          ],
    );
  });

  tearDown(() {
    moviesBloc.close();
  });
}