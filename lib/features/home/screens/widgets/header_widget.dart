import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/services/notification_reponsitory.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const HeaderWidget({Key? key, required this.userName, this.onNotificationTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(CSizes.xl),
          bottomRight: Radius.circular(CSizes.xl),
        ),
      ),
      padding: const EdgeInsets.all(CSizes.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                userName,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: CColors.dark),
              ),
              SizedBox(height: CSizes.sm),
              Text(
                'Stay updated with campus events',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: CColors.black),
              ),
            ],
          ),
          Obx(() {
            try {
              final hasUnread = NotificationController.instance.hasUnread;
              return Stack(
                children: [
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: Icon(Icons.notifications_outlined, size: 28),
                    color: dark ? CColors.white : CColors.black,
                  ),
                  if (hasUnread)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: CColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            } catch (e) {
              return IconButton(
                onPressed: onNotificationTap,
                icon: Icon(Icons.notifications_outlined, size: 28),
                color: dark ? CColors.white : CColors.black,
              );
            }
          }),
        ],
      ),
    );
  }
}
