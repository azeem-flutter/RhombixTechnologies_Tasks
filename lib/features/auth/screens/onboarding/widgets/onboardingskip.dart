import 'package:campuspulse/features/auth/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
      top: CHelperFunctions.getAppBarHeight(),
      right: CSizes.lg,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: Text(
          'Skip',
          style: TextStyle(color: dark ? CColors.white : CColors.black),
        ),
      ),
    );
  }
}
