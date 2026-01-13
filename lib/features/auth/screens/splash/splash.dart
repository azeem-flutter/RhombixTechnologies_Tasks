import 'package:campuspulse/features/auth/screens/login/login.dart';
import 'package:campuspulse/features/auth/screens/onboarding/onboarding.dart';
import 'package:campuspulse/navigation_menu.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = AuthenticationRepository.instance.authUser;
    if (user != null) {
      Get.offAll(() => const NavigationMenu());
    } else {
      // Check if first time
      if (GetPlatform.isWeb) {
        // On web, default to onboarding
        Get.offAll(const OnboardingScreen());
      } else {
        final deviceStorage = AuthenticationRepository.instance.deviceStorage;
        if (deviceStorage != null) {
          deviceStorage.writeIfNull('isFirstTime', true);
          final isFirstTime = deviceStorage.read('isFirstTime') ?? true;
          if (isFirstTime) {
            Get.offAll(const OnboardingScreen());
          } else {
            Get.offAll(() => const LoginScreen());
          }
        } else {
          Get.offAll(const OnboardingScreen());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.school, size: 60, color: CColors.primary),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            // App Name
            const Text(
              'Campus Pulse',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: CSizes.md),

            // Tagline
            Text(
              'Your Campus, Your Pulse',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.8),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
