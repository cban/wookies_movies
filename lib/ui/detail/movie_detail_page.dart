import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wookies_movies/ui/detail/cast_section.dart';
import 'package:wookies_movies/ui/widgets/movie_banner_widget.dart';
import 'package:wookies_movies/ui/detail/movie_title_section.dart';
import 'package:wookies_movies/ui/detail/overview_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/movies/detail/movie_detail_bloc.dart';
import '../../bloc/movies/detail/movie_detail_event.dart';
import '../../bloc/movies/detail/movie_detail_state.dart';
import '../../data/model/movies/movie.dart';
import '../../di/injectable.dart';

class MovieDetailPage extends StatelessWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt<MovieDetailBloc>()..add(GetMovieDetail(movieId)),
      child: Scaffold(
        appBar: AppBar(title:  Text(AppLocalizations.of(context)!.moviesDetails)),
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return _buildMovieDetail(state.movie, context);
            }
            if (state is MovieDetailError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildMovieDetail(Movie movie, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieBannerWidget(
              imageUrl: movie.backdrop,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            MovieTitleSection(movie: movie),
            const SizedBox(height: 16),
            CastSection(cast: movie.cast),
            const SizedBox(height: 8),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 8),
            OverViewSection(overview: movie.overview),
          ],
        ),
      ),
    );
  }
}
