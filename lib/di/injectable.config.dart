// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:wookies_movies/bloc/movies/detail/movie_detail_bloc.dart'
    as _i322;
import 'package:wookies_movies/bloc/movies/movies_bloc.dart' as _i842;
import 'package:wookies_movies/data/local/shared_pref_data.dart' as _i309;
import 'package:wookies_movies/data/remote/api_service.dart' as _i631;
import 'package:wookies_movies/di/injectable.dart' as _i837;
import 'package:wookies_movies/repository/movies_repository.dart' as _i1038;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i309.SharedPrefData>(() => _i309.SharedPrefData());
    gh.singleton<_i361.Dio>(() => appModule.dio);
    gh.singleton<_i631.ApiService>(() => _i631.ApiService(gh<_i361.Dio>()));
    gh.factory<_i1038.MoviesRepository>(
      () => _i1038.MoviesRepository(
        gh<_i631.ApiService>(),
        gh<_i309.SharedPrefData>(),
      ),
    );
    gh.factory<_i842.MoviesBloc>(
      () => _i842.MoviesBloc(repository: gh<_i1038.MoviesRepository>()),
    );
    gh.factory<_i322.MovieDetailBloc>(
      () => _i322.MovieDetailBloc(repository: gh<_i1038.MoviesRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i837.AppModule {}
