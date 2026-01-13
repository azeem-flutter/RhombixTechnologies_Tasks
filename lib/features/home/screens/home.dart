import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/features/home/screens/widgets/event_card_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/event_detail_screen.dart';
import 'package:campuspulse/features/home/screens/widgets/event_form.dart';
import 'package:campuspulse/features/home/screens/widgets/featured_event_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/header_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/tab_selector_widget.dart';
import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/features/notification/screens/notification_screen.dart';
import 'package:campuspulse/features/profile/controllers/profile_controller.dart';

import 'package:campuspulse/services/notification_reponsitory.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:campuspulse/services/event_repository.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatelessWidget {
  final EventRepository eventRepo = Get.put(EventRepository());

  final selectedTab = 0.obs;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eventRepo.fetchEvents();
      final now = DateTime.now();

      for (var event in eventRepo.events) {
        final diffDays = event.eventDateTime
            .difference(DateTime(now.year, now.month, now.day))
            .inDays;

        if (diffDays == 1) {
          NotificationController.instance.addEventNotification(event);

          final flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          const AndroidNotificationDetails androidDetails =
              AndroidNotificationDetails(
                'event_channel',
                'Event Notifications',
                channelDescription: 'Notifications for upcoming events',
                importance: Importance.max,
                priority: Priority.high,
              );
          const NotificationDetails platformDetails = NotificationDetails(
            android: androidDetails,
          );

          await flutterLocalNotificationsPlugin.zonedSchedule(
            event.id.hashCode,
            'Event Reminder',
            'Your event "${event.title}" is tomorrow!',
            tz.TZDateTime.from(
              event.eventDateTime.subtract(const Duration(days: 1)),
              tz.local,
            ),
            platformDetails,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
        }
      }
    });
    // fetch event once
    eventRepo.fetchEvents();

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => HeaderWidget(
              userName: controller.user.value.username,
              onNotificationTap: () =>
                  Get.to(() => NotificationScreen(backArrow: true)),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwSections),
          Obx(() {
            final allEvents = eventRepo.events;
            final now = DateTime.now();
            final upcomingEvents =
                allEvents.where((e) => e.eventDateTime.isAfter(now)).toList()
                  ..sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));
            final nextEvent = upcomingEvents.isNotEmpty
                ? upcomingEvents.first
                : null;
            return FeaturedEventWidget(
              title: nextEvent?.title ?? 'No Upcoming Events',
              date: nextEvent?.date ?? '',
              time: nextEvent?.time ?? '',
              onTap: () {},
            );
          }),
          const SizedBox(height: CSizes.spaceBtwSections),
          Obx(() {
            return TabSelectorWidget(
              selectedIndex: selectedTab.value,
              onTabSelected: (index) => selectedTab.value = index,
            );
          }),
          const SizedBox(height: CSizes.spaceBtwSections),
          Expanded(
            child: Obx(() {
              final allEvents = eventRepo.events;
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              List<EventModel> events;
              if (selectedTab.value == 0) {
                // All Events upcoming
                events =
                    allEvents
                        .where((e) => e.eventDateTime.isAfter(now))
                        .toList()
                      ..sort(
                        (a, b) => a.eventDateTime.compareTo(b.eventDateTime),
                      );
              } else if (selectedTab.value == 1) {
                // Today
                events =
                    allEvents.where((e) {
                      final eventDate = DateTime(
                        e.eventDateTime.year,
                        e.eventDateTime.month,
                        e.eventDateTime.day,
                      );
                      return eventDate.isAtSameMomentAs(today);
                    }).toList()..sort(
                      (a, b) => a.eventDateTime.compareTo(b.eventDateTime),
                    );
              } else {
                // Important
                events = allEvents.where((e) => e.isImportant).toList()
                  ..sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));
              }

              if (events.isEmpty) {
                return Center(child: Text('No events found'));
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
                children: events.map((event) {
                  return EventCardWidget(
                    event: event,
                    onTap: () {
                      Get.to(() => EventDetailScreen(event: event));
                    },
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => AddEventScreen());
        },
        backgroundColor: CColors.primary,
        child: Icon(Icons.add, size: CSizes.lg, color: CColors.white),
      ),
    );
  }
}
