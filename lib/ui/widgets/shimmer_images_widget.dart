import 'package:flutter/material.dart';

import 'shimmer_card_row.dart';

class ShimmerImagesWidget extends StatelessWidget {
  final int itemCount;

  final double height;

  const ShimmerImagesWidget({this.itemCount = 3, this.height = 200, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return ShimmerCardRow(
              width: 220,
              height: 100,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            );
          },
        ),
      ),
    );
  }
}
