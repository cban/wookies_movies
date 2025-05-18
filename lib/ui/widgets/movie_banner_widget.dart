import 'package:flutter/material.dart';
import 'package:wookies_movies/ui/widgets/shimmer_card_row.dart';

class MovieBannerWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BoxFit fit;

  const MovieBannerWidget({
    super.key,
    required this.imageUrl,
    this.height = 300,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Center(
            child: ShimmerCardRow(
              width: double.infinity,
              height: height,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ),
          ),
        );
      },
    );
  }
}

