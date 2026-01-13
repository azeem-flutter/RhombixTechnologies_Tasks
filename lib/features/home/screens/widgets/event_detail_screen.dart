import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
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
            _row(Icons.calendar_month, event.date),
            _row(Icons.access_time, event.time),
            _row(Icons.location_on, event.location),
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

  Widget _row(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [Icon(icon, size: 20), const SizedBox(width: 10), Text(text)],
      ),
    );
  }
}
