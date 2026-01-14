import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:campuspulse/widgets/Icon_widget.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconWidget(icon: Icons.calendar_month, text: event.date),
            IconWidget(icon: Icons.access_time, text: event.time),
            IconWidget(icon: Icons.location_on, text: event.location),
            const SizedBox(height: CSizes.lg),

            if (event.isImportant)
              Chip(
                label: const Text('Important'),
                backgroundColor: CColors.primary,
              ),

            const SizedBox(height: CSizes.lg),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
