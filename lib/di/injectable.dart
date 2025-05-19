import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    ..options.baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://wookie.codesubmit.io'
    ..options.headers = {
      'Authorization': dotenv.env['API_TOKEN'] ?? '',
      'Content-Type': 'application/json',
    };
}