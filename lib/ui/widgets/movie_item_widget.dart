import 'package:flutter/material.dart';
import 'package:wookies_movies/data/model/movies/movie_data.dart';

import '../style/app_style.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieItemData data;

  const MovieItemWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Card(
        color: AppStyle.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            data.onTap(context);
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  data.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const SizedBox(width: 200, height: 200),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    data.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppStyle.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
