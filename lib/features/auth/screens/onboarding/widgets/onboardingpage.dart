import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });
  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CSizes.lg),
      child: Column(
        children: [
          const SizedBox(height: CSizes.spaceBtwSections * 3.5),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: CColors.primary,
              borderRadius: BorderRadius.circular(CSizes.lg),
            ),
            child: Center(
              child: Icon(icon, size: CSizes.xl * 3, color: CColors.white),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwitems),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CSizes.spaceBtwitems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
