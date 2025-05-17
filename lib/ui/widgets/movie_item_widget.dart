import 'package:wookies_movies/data/model/movies/movie_data.dart';
import 'package:wookies_movies/data/model/movies/movies_response.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieItemData data;
  const MovieItemWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
      color: AppStyle.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          data.onTap(context);
        },
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Image.network(
                data.imagePath,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(width: 100),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
