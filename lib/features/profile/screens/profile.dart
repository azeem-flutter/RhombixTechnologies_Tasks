import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                children: [
                  // Profile Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
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

                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student User',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: CSizes.xs),
                        Text(
                          'student@college.edu',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: CSizes.spaceBtwSections),

              // Email Info Card
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
                    Icon(
                      Icons.email_outlined,
                      color: dark ? CColors.white : Colors.grey.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: CSizes.sm),
                    Text(
                      'Email:  ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      'student@college.edu',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: CSizes.spaceBtwSections),

              // Settings Section
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: CSizes.spaceBtwitems),

              // Enable Notifications Setting
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
                      child: Icon(
                        Icons.notifications_outlined,
                        color: CColors.white,
                        size: CSizes.lg,
                      ),
                    ),
                    const SizedBox(width: CSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable Dark Mode',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: CSizes.xs),
                          Text(
                            'Receive alerts and updates',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                      activeThumbColor: dark
                          ? CColors.darkerGrey
                          : CColors.primary.withValues(alpha: 0.1),
                      activeTrackColor: dark
                          ? CColors.primary
                          : CColors.darkerGrey,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: CSizes.sm),

              // About App Setting
              InkWell(
                onTap: () {
                  // Handle about app tap
                },
                borderRadius: BorderRadius.circular(CSizes.sm),
                child: Container(
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
                        child: Icon(
                          Icons.info_outline,
                          color: CColors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: CSizes.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About App',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: CSizes.xs),
                            Text(
                              'Version 1.0.0',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwitems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
