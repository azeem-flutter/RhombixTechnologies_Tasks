import 'package:campuspulse/features/auth/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:campuspulse/features/auth/screens/onboarding/widgets/onboardingdotnavigation.dart';
import 'package:campuspulse/features/auth/screens/onboarding/widgets/onboardingnextbutton.dart';
import 'package:campuspulse/features/auth/screens/onboarding/widgets/onboardingpage.dart';
import 'package:campuspulse/features/auth/screens/onboarding/widgets/onboardingskip.dart';
import 'package:campuspulse/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scroll page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                icon: Icons.calendar_month,
                title: CTexts.onBoardingTitle1,
                subTitle: CTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                icon: Icons.notifications_outlined,
                title: CTexts.onBoardingTitle2,
                subTitle: CTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                icon: Icons.file_copy_outlined,
                title: CTexts.onBoardingTitle3,
                subTitle: CTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation SmoothPageIndicator
          OnBoardingdotNavigation(),
          // Next button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
