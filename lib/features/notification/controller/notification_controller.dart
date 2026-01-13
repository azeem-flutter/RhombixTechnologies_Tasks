import 'package:campuspulse/features/notification/model/notification_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../home/models/event_model.dart';
import '../../../services/notification_reponsitory.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    NotificationRepository.instance.getNotifications().listen((data) {
      notifications.value = data;
    });
  }

  bool get hasUnread =>
      notifications.any((notification) => notification.isRead == false);

  Future<void> addEventNotification(EventModel event) async {
    final alreadyExists = notifications.any((n) => n.id == event.id);

    if (alreadyExists) return;

    // Parse event date
    DateTime eventDate;
    try {
      eventDate = DateFormat('dd/MM/yyyy').parse(event.date);
    } catch (e) {
      return; // Invalid date format
    }

    // Check if event is tomorrow
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    if (eventDate.year != tomorrow.year ||
        eventDate.month != tomorrow.month ||
        eventDate.day != tomorrow.day) {
      return; // Not tomorrow, don't create notification
    }

    final notification = AppNotification(
      id: event.id,
      title: 'Upcoming Event',
      body: '${event.title} is happening tomorrow!',
      receivedAt: DateTime.now(),
      isRead: false,
    );

    await NotificationRepository.instance.createNotification(notification);
  }

  Future<void> markAsRead(AppNotification notification) async {
    if (!notification.isRead) {
      await NotificationRepository.instance.markAsRead(notification.id);
    }
  }
}
