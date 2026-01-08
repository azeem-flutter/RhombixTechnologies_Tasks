import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final bool isImportant;
  final VoidCallback? onTap;

  const EventCardWidget({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    this.isImportant = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: CSizes.sm),
        padding: const EdgeInsets.all(CSizes.md),
        decoration: BoxDecoration(
          color: dark ? CColors.darkGrey : Colors.white,
          borderRadius: BorderRadius.circular(CSizes.md),
          border: Border.all(color: CColors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: CColors.primary,
                borderRadius: BorderRadius.circular(CSizes.sm),
              ),
              child: Icon(Icons.calendar_month, color: CColors.white, size: 28),
            ),
            const SizedBox(width: CSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      if (isImportant)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: CColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Important',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: CColors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: CSizes.sm),
                  Text(
                    '$date  •  $time',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: CColors.darkGrey,
                      ),
                      const SizedBox(width: CSizes.xs),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
