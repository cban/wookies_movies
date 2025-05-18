import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wookies_movies/bloc/movies/movies_bloc.dart';
import 'package:wookies_movies/bloc/movies/movies_event.dart';
import 'package:wookies_movies/bloc/movies/movies_state.dart';
import 'package:wookies_movies/di/injectable.dart';
import 'package:wookies_movies/ui/dashboard/movie_list_content.dart';
import 'package:wookies_movies/ui/widgets/search_widget.dart';

import '../widgets/shimmer_images_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesBloc _moviesBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moviesBloc = getIt<MoviesBloc>();
    _moviesBloc.add(GetMoviesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _moviesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SearchWidget(
                searchController: _searchController,
                moviesBloc: _moviesBloc,
                hintText: AppLocalizations.of(context)!.searchMovies,
              ),
            ),
          ),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return ShimmerImagesWidget();
            } else if (state is MoviesLoaded) {
              return MovieListContent(movies: state.movies);
            } else if (state is MoviesError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.errorMessage({state.message}),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
