import 'package:campuspulse/features/home/screens/home.dart';
import 'package:campuspulse/features/notification/screens/notification_screen.dart';
import 'package:campuspulse/features/profile/screens/profile.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndexFunction(value),

          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home, color: CColors.primary, size: 28),
            ),

            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notification',
              selectedIcon: Icon(
                Icons.notifications,
                color: CColors.primary,
                size: 28,
              ),
            ),

            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
              selectedIcon: Icon(
                Icons.person,
                color: CColors.primary,
                size: 28,
              ),
            ),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    NotificationScreen(),
    const ProfileSettingsScreen(),
  ].obs;

  void selectedIndexFunction(int index) {
    selectedIndex.value = index;
  }
}
