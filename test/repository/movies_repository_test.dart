import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wookies_movies/data/local/shared_pref_data.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:wookies_movies/data/remote/api_service.dart';
import 'package:wookies_movies/repository/movies_repository.dart';

@GenerateMocks([ApiService, SharedPrefData])
import 'movies_repository_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late MockSharedPrefData mockSharedPrefData;
  late MoviesRepository subjectUnderTest;

  setUp(() {
    mockApiService = MockApiService();
    mockSharedPrefData = MockSharedPrefData();
    subjectUnderTest = MoviesRepository(mockApiService, mockSharedPrefData);
  });

  group('getMovies', () {
    test('returns MoviesResponse from API when no cached data', () async {
      final movies = [
        Movie(
          id: "1",
          title: "Test Movie",
          overview: "Test overview",
          backdrop: "backdrop.jpg",
          poster: "poster.jpg",
          imdbRating: 8.5,
          length: "2h",
          director: "Director",
          classification: "PG",
          releasedOn: "2022-01-01",
          slug: "test-movie",
          cast: ["Actor 1"],
          genres: ["Action"],
        ),
      ];

      final moviesResponse = MoviesResponse(movies: movies);

      when(
        mockSharedPrefData.getCachedMovies(),
      ).thenAnswer((_) => Future.value(null));

      when(mockApiService.getMovies()).thenAnswer((_) async => moviesResponse);

      final result = await subjectUnderTest.getMovies();

      expect(result, equals(moviesResponse));
      verify(mockApiService.getMovies()).called(1);
      verify(mockSharedPrefData.getCachedMovies()).called(1);
      verify(mockSharedPrefData.cacheMovies(moviesResponse)).called(1);
    });

    test('returns cached Movies when cache exists', () async {
      final movies = [
        Movie(
          id: "2",
          title: "Cached Movie",
          overview: "Cached overview",
          backdrop: "cached_backdrop.jpg",
          poster: "cached_poster.jpg",
          imdbRating: 7.5,
          length: "1h 45m",
          director: "Cached Director",
          classification: "PG-13",
          releasedOn: "2021-05-15",
          slug: "cached-movie",
          cast: ["Cached Actor"],
          genres: ["Drama"],
        ),
      ];

      final cachedMoviesResponse = MoviesResponse(movies: movies);

      when(
        mockSharedPrefData.getCachedMovies(),
      ).thenAnswer((_) => Future.value(cachedMoviesResponse));

      final result = await subjectUnderTest.getMovies();

      expect(result, equals(cachedMoviesResponse));
      verifyNever(mockApiService.getMovies());
      verify(mockSharedPrefData.getCachedMovies()).called(1);
    });
  });

  group('getMovieById', () {
    final movieId = "1";
    final testMovie = Movie(
      id: "1",
      title: "Test Movie",
      overview: "Test overview",
      backdrop: "backdrop.jpg",
      poster: "poster.jpg",
      imdbRating: 8.5,
      length: "2h",
      director: "Director",
      classification: "PG",
      releasedOn: "2022-01-01",
      slug: "test-movie",
      cast: ["Actor 1"],
      genres: ["Action"],
    );
    final otherMovie = Movie(
      id: "2",
      title: "Other Movie",
      overview: "Other overview",
      backdrop: "other_backdrop.jpg",
      poster: "other_poster.jpg",
      imdbRating: 7.0,
      length: "1h 30m",
      director: "Other Director",
      classification: "R",
      releasedOn: "2023-01-01",
      slug: "other-movie",
      cast: ["Other Actor"],
      genres: ["Horror"],
    );

    test('returns movie from cache when it exists', () async {
      final cachedMovies = MoviesResponse(movies: [testMovie, otherMovie]);

      when(
        mockSharedPrefData.getCachedMovies(),
      ).thenAnswer((_) => Future.value(cachedMovies));

      final result = await subjectUnderTest.getMovieById(movieId);

      expect(result, equals(testMovie));
      verify(mockSharedPrefData.getCachedMovies()).called(1);
      verifyNever(mockApiService.getMovies());
    });

    test('fetches from API when cache is empty', () async {
      final apiMovies = MoviesResponse(movies: [testMovie, otherMovie]);

      when(
        mockSharedPrefData.getCachedMovies(),
      ).thenAnswer((_) => Future.value(null));
      when(mockApiService.getMovies()).thenAnswer((_) async => apiMovies);

      final result = await subjectUnderTest.getMovieById(movieId);

      expect(result, equals(testMovie));
      verify(mockSharedPrefData.getCachedMovies()).called(1);
      verify(mockApiService.getMovies()).called(1);
      verify(mockSharedPrefData.cacheMovies(apiMovies)).called(1);
    });

    test('throws exception when movie not found', () async {
      final differentMovieId = "3";
      final apiMovies = MoviesResponse(movies: [testMovie, otherMovie]);

      when(
        mockSharedPrefData.getCachedMovies(),
      ).thenAnswer((_) => Future.value(null));
      when(mockApiService.getMovies()).thenAnswer((_) async => apiMovies);

      expect(
        () => subjectUnderTest.getMovieById(differentMovieId),
        throwsA(isA<StateError>()),
      );
    });
  });
}
