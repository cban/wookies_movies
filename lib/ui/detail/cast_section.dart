
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CastSection extends StatelessWidget {
  const CastSection({super.key, required this.cast});

  final List<String> cast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.cast),
        const SizedBox(width: 8),
        Flexible(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cast.map((actor) => Text(actor)).toList(),
          ),
        ),
      ],
    );
  }
}
