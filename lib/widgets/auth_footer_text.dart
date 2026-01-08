import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AuthFooterText extends StatelessWidget {
  const AuthFooterText({
    super.key,
    required this.footText,
    required this.authText,
    required this.onPressed,
  });
  final String footText, authText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(footText, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(width: CSizes.xs),

        TextButton(
          onPressed: onPressed,
          child: Text(
            authText,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: CColors.primary),
          ),
        ),
      ],
    );
  }
}
