import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/features/notification/model/notification_model.dart';
import 'package:campuspulse/services/notification_reponsitory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:timezone/timezone.dart' as tz;

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid => AuthenticationRepository.instance.authUser!.uid;

  final events = <EventModel>[].obs;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  EventRepository() {
    _initializeNotifications();
  }

  // Initialize notifications
  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Add event
  Future<void> addEvent(EventModel event) async {
    final userId = AuthenticationRepository.instance.authUser?.uid;
    if (userId == null) throw 'User not logged in';

    await _db
        .collection('Users')
        .doc(userId)
        .collection('Events')
        .doc(event.id)
        .set(event.toJson());

    events.add(event);

    final scheduledDate = event.eventDateTime.subtract(const Duration(days: 1));

    if (scheduledDate.isAfter(DateTime.now())) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'event_channel',
            'Event Notifications',
            channelDescription: 'Notifications for upcoming events',
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        event.id.hashCode,
        'Event Reminder',
        'Your event "${event.title}" is tomorrow!',
        tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  // Fetch events for current user
  Future<void> fetchEvents() async {
    final userId = AuthenticationRepository.instance.authUser?.uid;
    if (userId == null) throw 'User not logged in';

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('Events')
        .orderBy('createdAt', descending: true)
        .get();

    events.value = snapshot.docs
        .map((doc) => EventModel.fromSnapshot(doc))
        .toList();
  }

  // Update a specific event
  Future<void> updateEvent(String eventId, Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(_uid)
          .collection("Events")
          .doc(eventId)
          .update(json);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete a specific event
  Future<void> deleteEvent(String eventId) async {
    try {
      await _db
          .collection("Users")
          .doc(_uid)
          .collection("Events")
          .doc(eventId)
          .delete();

      await _flutterLocalNotificationsPlugin.cancel(eventId.hashCode);

      events.removeWhere((e) => e.id == eventId);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> checkUpcomingEventsAndNotify(List<EventModel> events) async {
    final now = DateTime.now();

    for (final event in events) {
      final eventDate = _parseDate(event.date);

      final difference = eventDate.difference(now).inDays;

      if (difference == 1) {
        final notification = AppNotification(
          id: event.id,
          title: 'Upcoming Event',
          body: '${event.title} is happening tomorrow!',
          receivedAt: DateTime.now(),
        );

        await NotificationRepository.instance.createNotification(notification);
      }
    }
  }

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }
}
