import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String timeAgo;

  const NotificationCard({
    Key? key,

    required this.title,
    required this.description,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.only(bottom: CSizes.sm),
      decoration: BoxDecoration(
        color: dark ? CColors.darkerGrey80 : CColors.white,
        borderRadius: BorderRadius.circular(CSizes.lg),
        border: Border.all(
          color: dark
              ? CColors.white.withValues(alpha: 0.1)
              : CColors.black.withValues(alpha: 0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: CColors.white90,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(CSizes.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: CColors.primary,
                borderRadius: BorderRadius.circular(CSizes.sm),
              ),
              child: Icon(
                Icons.calendar_month_outlined,
                color: CColors.white,
                size: CSizes.lg,
              ),
            ),
            const SizedBox(width: CSizes.sm),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: CSizes.xs),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: CSizes.sm),
                  Text(timeAgo, style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),

            // Dot Indicator
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: CSizes.xs),
              decoration: BoxDecoration(
                color: CColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
