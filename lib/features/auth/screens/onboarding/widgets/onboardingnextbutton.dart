import 'package:campuspulse/features/auth/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/constants/text_strings.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: CHelperFunctions.getbottomNavigationBarHeight(),
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(CSizes.sm),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => OnboardingController.instance.nextPage(),
            child: const Text(CTexts.getStarted),
          ),
        ),
      ),
    );
  }
}
