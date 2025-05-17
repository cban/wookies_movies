import 'package:flutter/cupertino.dart';

import '../../data/model/movies/movie.dart';
import '../../data/model/movies/movie_data.dart';
import 'movie_item_widget.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;

  const MovieListWidget({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieItemWidget(
            data: MovieItemData(
              title: movie.title,
              imagePath: movie.poster,
              onTap: (context) {},
            ),
          );
        },
      ),
    );
  }
}
