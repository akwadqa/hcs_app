import 'package:flutter/material.dart';
import 'package:hcs/src/theme/app_colors.dart';

class StarredText extends StatelessWidget {
  final String text;

  const StarredText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          TextSpan(
            text: ' *',
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
