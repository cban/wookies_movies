import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wookies_movies/bloc/movies/movies_bloc.dart';
import 'package:wookies_movies/bloc/movies/movies_event.dart';
import 'package:wookies_movies/bloc/movies/movies_state.dart';
import 'package:wookies_movies/data/model/movies/movie_data.dart';
import 'package:wookies_movies/di/injectable.dart';
import 'package:wookies_movies/ui/widgets/movie_item_widget.dart';
import 'package:wookies_movies/ui/widgets/search_widget.dart';
import 'package:wookies_movies/ui/widgets/shimmer_card_row.dart';

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
          title: const Text('Wookies Movies'),
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
                hintText: 'Search movies',
              ),
            ),
          ),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return ShimmerCardRow(
                width: double.infinity,
                height: 100,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
              );
            } else if (state is MoviesLoaded) {
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieItemWidget(
                    data: MovieItemData(
                      title: movie.title,
                      imagePath: movie.poster,
                      onTap: (context) {},
                    ),
                  );
                },
              );
            } else if (state is MoviesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

