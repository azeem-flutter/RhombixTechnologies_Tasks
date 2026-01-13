import 'package:campuspulse/features/profile/controllers/profile_controller.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    final dark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile & Settings',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: CColors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROFILE HEADER
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: CColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: CSizes.md),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          profileController.user.value.username,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: CSizes.xs),
                      Obx(
                        () => Text(
                          profileController.user.value.email,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: CSizes.spaceBtwSections),

            /// SETTINGS TITLE
            Text('Settings', style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: CSizes.spaceBtwitems),

            /// DARK MODE TOGGLE
            Container(
              padding: const EdgeInsets.all(CSizes.md),
              decoration: BoxDecoration(
                color: dark
                    ? CColors.darkerGrey
                    : CColors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(CSizes.sm),
                border: Border.all(
                  color: dark
                      ? CColors.darkerGrey
                      : CColors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(CSizes.sm),
                    decoration: BoxDecoration(
                      color: CColors.primary,
                      borderRadius: BorderRadius.circular(CSizes.sm),
                    ),
                    child: const Icon(
                      Icons.dark_mode_outlined,
                      color: CColors.white,
                      size: CSizes.lg,
                    ),
                  ),
                  const SizedBox(width: CSizes.sm),
                  const Expanded(child: Text('Enable Dark Mode')),
                  Obx(
                    () => Switch(
                      value: profileController.isDarkMode.value,
                      onChanged: profileController.toggleTheme,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),
            Container(
              padding: const EdgeInsets.all(CSizes.md),
              decoration: BoxDecoration(
                color: dark
                    ? CColors.darkerGrey
                    : CColors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(CSizes.sm),
                border: Border.all(
                  color: dark
                      ? CColors.darkerGrey
                      : CColors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(CSizes.sm),
                    decoration: BoxDecoration(
                      color: CColors.primary,
                      borderRadius: BorderRadius.circular(CSizes.sm),
                    ),
                    child: const Icon(
                      Icons.info,
                      color: CColors.white,
                      size: CSizes.lg,
                    ),
                  ),
                  const SizedBox(width: CSizes.sm),
                  const SizedBox(
                    child: Column(
                      children: [
                        Text('About App'),
                        SizedBox(height: CSizes.sm),
                        Text('1.1 Version'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            /// LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
