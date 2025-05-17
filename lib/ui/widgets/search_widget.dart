import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/movies/movies_bloc.dart';
import '../../bloc/movies/movies_event.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchController;
  final MoviesBloc _moviesBloc;
  final String? hintText;

  const SearchWidget({
    super.key,
    required TextEditingController searchController,
    required MoviesBloc moviesBloc,
    this.hintText,
  }) : _searchController = searchController,
        _moviesBloc = moviesBloc;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if(_searchController.text.isNotEmpty) {
              _moviesBloc.add(GetMoviesEvent());
            }
            _searchController.clear();

          },
        ),
      ),
      onChanged: (query) {
        if (query.isNotEmpty) {
          _moviesBloc.add(SearchMoviesEvent(query));
        } else {
          _moviesBloc.add(GetMoviesEvent());
        }
      },
    );
  }
}
