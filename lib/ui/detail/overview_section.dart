
import 'package:flutter/widgets.dart';

class OverViewSection extends StatelessWidget {
  const OverViewSection({
    super.key,
    required this.overview,
  });

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(overview)],
    );
  }
}