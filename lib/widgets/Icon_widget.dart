import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: CSizes.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: CSizes.lg,
            color: dark ? CColors.white : CColors.black,
          ),
          const SizedBox(width: CSizes.md),
          Text(text),
        ],
      ),
    );
  }
}
