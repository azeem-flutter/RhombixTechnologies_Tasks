import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;

  const EventCardWidget({super.key, required this.event, this.onTap});

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
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: CColors.primary,
                borderRadius: BorderRadius.circular(CSizes.sm),
              ),
              child: const Icon(
                Icons.calendar_month,
                color: CColors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: CSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: CColors.black),
                        ),
                      ),
                      if (event.isImportant)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: CColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Important',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: CSizes.sm),
                  Text(
                    '${event.date} • ${event.time}',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: CColors.black),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: CColors.darkGrey,
                      ),
                      const SizedBox(width: CSizes.xs),
                      Text(
                        event.location,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: CColors.black),
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
