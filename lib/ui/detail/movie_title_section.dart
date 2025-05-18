
import 'package:flutter/widgets.dart';
import 'package:wookies_movies/data/model/movies/movie.dart';
import 'package:wookies_movies/ui/style/app_style.dart';
import 'package:wookies_movies/ui/widgets/start_rating_widget.dart';

class MovieTitleSection extends StatelessWidget {
  final Movie movie;

  const MovieTitleSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${movie.title} (${movie.imdbRating} / 10)',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${_extractYear(movie.releasedOn)} | ${movie.length} | ${movie.director}',
          style: TextStyle(fontSize: 16, color: AppStyle.primaryTextColor),
        ),
        const SizedBox(height: 4),
        StartRatingWidget(rating: movie.imdbRating),
      ],
    );
  }

  String _extractYear(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return date.year.toString();
    } catch (e) {
      return dateString;
    }
  }
}
