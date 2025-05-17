import 'package:flutter/widgets.dart';

class MovieItemData {
  String imagePath;
  String title;
  Function(BuildContext) onTap;

  MovieItemData({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
}

