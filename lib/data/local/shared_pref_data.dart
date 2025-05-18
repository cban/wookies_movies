import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/movies/movies_response.dart';

@injectable
class SharedPrefData {
  static const String cacheKey = 'movies_cache';
  static const String cacheDurationKey = 'cache_duration';
  static const Duration cacheDuration = Duration(hours: 1);

  Future<void> cacheMovies(MoviesResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(response.toJson()));
    await prefs.setInt(cacheDurationKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<MoviesResponse?> getCachedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(cacheKey);
    final int? timestamp = prefs.getInt(cacheDurationKey);

    if (cachedData != null && timestamp != null) {
      final DateTime cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cacheTime) < cacheDuration) {
        try {
          final Map<String, dynamic> json = jsonDecode(cachedData);
          return MoviesResponse.fromJson(json);
        } catch (e) {
          return null;
        }
      } else {
        clearCache();
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
    await prefs.remove(cacheDurationKey);
  }
}
