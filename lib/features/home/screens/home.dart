import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/features/home/screens/widgets/event_card_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/event_form.dart';
import 'package:campuspulse/features/home/screens/widgets/featured_event_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/header_widget.dart';
import 'package:campuspulse/features/home/screens/widgets/tab_selector_widget.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  int bottomNavIndex = 0;

  final List<Event> allEvents = [
    Event(
      title: 'Tech Workshop: AI & ML',
      date: 'Jan 15, 2026',
      time: '10:00 AM',
      location: 'Main Auditorium',
      isImportant: true,
    ),
    Event(
      title: 'Career Fair 2026',
      date: 'Jan 20, 2026',
      time: '9:00 AM',
      location: 'Sports Complex',
      isImportant: false,
    ),
  ];

  List<Event> get filteredEvents {
    if (selectedTab == 2) {
      return allEvents.where((e) => e.isImportant).toList();
    }
    return allEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Widget
          HeaderWidget(
            userName: 'Student',
            onNotificationTap: () {
              // Handle notification tap
            },
          ),

          const SizedBox(height: CSizes.spaceBtwSections),

          // Featured Event Widget
          FeaturedEventWidget(
            title: 'Tech Workshop: AI & ML',
            date: 'Jan 15, 2026',
            time: '10:00 AM',
            onTap: () {
              // Handle featured event tap
            },
          ),

          const SizedBox(height: CSizes.spaceBtwSections),

          // Tab Selector Widget
          TabSelectorWidget(
            selectedIndex: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: CSizes.spaceBtwSections),

          // Event List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
              children: filteredEvents.map((event) {
                return EventCardWidget(
                  title: event.title,
                  date: event.date,
                  time: event.time,
                  location: event.location,
                  isImportant: event.isImportant,
                  onTap: () {
                    // Handle event tap
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddEventScreen()),
        backgroundColor: CColors.primary,
        child: Icon(Icons.add, size: CSizes.lg, color: CColors.white),
      ),
    );
  }
}
