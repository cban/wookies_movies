import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:wookies_movies/data/remote/api_service.dart';

@GenerateMocks([ApiService])
import 'api_service_test.mocks.dart';

void main() {
  late MockApiService subjectUnderTest;

  setUp(() {
    subjectUnderTest = MockApiService();
  });

  test('getMovies returns Movies', () async {
    final expected = [
      Movie(
        id: "movieId",
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
      ),
      Movie(
        id: "d6822b7b-48bb-4b78-ad5e-9ba04c517ec8",
        title: "Titanic",
        overview: "Titanic.......",
        backdrop: "https://wookie.codesubmit.io/.jpg",
        poster: "https://wookie.codesubmit.io/jpg",
        imdbRating: 8.0,
        length: "2h 32min",
        director: " James Cameron",
        classification: "13+",
        releasedOn: "1997-07-16T00:00:00",
        slug: "titanic-1997",
        cast: ["Some Actor", "Some Actress"],
        genres: ["Drama"],
      ),
    ];

    final mockResponse = MoviesResponse(movies: expected);

    when(subjectUnderTest.getMovies()).thenAnswer((_) async => mockResponse);

    final result = await subjectUnderTest.getMovies();

    expect(result, isA<MoviesResponse>());
    expect(result.movies, expected);
  });

  test('searchMovies returns Valid Movie for query', () async {
    final expected = Movie(
      id: "d6822b7b-48bb-4b78-ad5e-9ba04c517ec8",
      title: "Titanic",
      overview: "Titanic.......",
      backdrop: "https://wookie.codesubmit.io/.jpg",
      poster: "https://wookie.codesubmit.io/jpg",
      imdbRating: 8.0,
      length: "2h 32min",
      director: " James Cameron",
      classification: "13+",
      releasedOn: "1997-07-16T00:00:00",
      slug: "titanic-1997",
      cast: ["Some Actor", "Some Actress"],
      genres: ["Drama"],
    );

    final mockResponse = MoviesResponse(movies: [expected]);

    when(
      subjectUnderTest.searchMovies('Titanic'),
    ).thenAnswer((_) async => mockResponse);

    final result = await subjectUnderTest.searchMovies('Titanic');

    expect(result, isA<MoviesResponse>());
    expect(result.movies.first, expected);
  });
}
