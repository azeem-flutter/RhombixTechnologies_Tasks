import 'package:campuspulse/features/notification/screens/notification_card.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  final bool? backArrow;
  NotificationScreen({Key? key, this.backArrow = false}) : super(key: key);

  // Sample data - replace with your database data
  final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.calendar_today,
      'iconBgColor': Color(0xFFE3F2FD),
      'title': 'New Event Added',
      'description': 'Tech Workshop: AI & ML has been scheduled for Jan 15',
      'timeAgo': '2 hours ago',
      'dotColor': Colors.blue,
    },
    {
      'icon': Icons.info_outline,
      'iconBgColor': Color(0xFFE8EAF6),
      'title': 'Important Update',
      'description': 'Career fair registration deadline extended to Jan 18',
      'timeAgo': '5 hours ago',
      'dotColor': Colors.blue,
    },
    {
      'icon': Icons.notifications_outlined,
      'iconBgColor': Color(0xFFFFF9C4),
      'title': 'Reminder',
      'description': 'Cultural fest registration opens tomorrow at 9 AM',
      'timeAgo': '1 day ago',
      'dotColor': Colors.orange,
    },
    {
      'icon': Icons.event_note,
      'iconBgColor': Color(0xFFE3F2FD),
      'title': 'Event Update',
      'description': 'Guest lecture venue changed to Lecture Hall 1',
      'timeAgo': '2 days ago',
      'dotColor': Colors.grey,
    },
    {
      'icon': Icons.campaign_outlined,
      'iconBgColor': Color(0xFFF3E5F5),
      'title': 'Campus Alert',
      'description': 'Library timings extended till 10 PM this week',
      'timeAgo': '3 days ago',
      'dotColor': Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,

        leading: backArrow == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: CColors.black),
                onPressed: Get.back,
              )
            : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: CColors.black),
            ),
            Text(
              'Stay updated with latest alerts',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: CColors.darkGrey),
            ),
          ],
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(CSizes.md),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            title: notifications[index]['title'],
            description: notifications[index]['description'],
            timeAgo: notifications[index]['timeAgo'],
          );
        },
      ),
    );
  }
}
