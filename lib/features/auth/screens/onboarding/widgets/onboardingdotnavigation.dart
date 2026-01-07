import 'package:campuspulse/features/auth/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingdotNavigation extends StatelessWidget {
  OnBoardingdotNavigation({super.key});
  final controller = OnboardingController.instance;
  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: CHelperFunctions.getbottomNavigationBarHeight() + 70,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: dark ? CColors.light : CColors.black,
            dotHeight: 6,
          ),
        ),
      ),
    );
  }
}
