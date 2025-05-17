import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureInjection() => getIt.init();

@module
abstract class AppModule {
  @singleton
  Dio get dio => Dio()
    ..options.headers = {
      'Authorization': 'Bearer Wookie2021',
      'Content-Type': 'application/json',
    };
}