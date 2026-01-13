import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/features/notification/screens/notification_card.dart';
import 'package:campuspulse/services/notification_reponsitory.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  final bool? backArrow;
  NotificationScreen({Key? key, this.backArrow = false}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.backArrow == true
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
      body: Obx(() {
        final notifications = NotificationController.instance.notifications;
        if (notifications.isEmpty) {
          return const Center(child: Text('No notifications'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(CSizes.md),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return GestureDetector(
              onTap: () {
                // Mark as read when tapped
                NotificationController.instance.markAsRead(notification);
              },
              child: NotificationCard(
                title: notification.title,
                description: notification.body,
                timeAgo: _timeAgo(notification.receivedAt),
                isRead: notification.isRead,
              ),
            );
          },
        );
      }),
    );
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
