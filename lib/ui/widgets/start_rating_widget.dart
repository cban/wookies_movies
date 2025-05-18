
import 'package:flutter/material.dart';

import '../style/app_style.dart';

class StartRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StartRatingWidget({
    super.key,
    required this.rating,
    this.size = 40.0,
    this.color = AppStyle.starRatingColor,
  });

  @override
  Widget build(BuildContext context) {
    final starRating = rating / 2;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < starRating.floor()) {
          return Icon(Icons.star, size: size, color: color);
        } else if (index < starRating.ceil() && starRating.floor() != starRating.ceil()) {
          return Icon(Icons.star_half, size: size, color: color);
        } else {
          return Icon(Icons.star_border, size: size, color: color);
        }
      }),
    );
  }
}