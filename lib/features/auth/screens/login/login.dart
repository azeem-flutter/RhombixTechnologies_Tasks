import 'package:campuspulse/features/auth/screens/register/register.dart';
import 'package:campuspulse/navigation_menu.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/constants/text_strings.dart';
import 'package:campuspulse/widgets/auth_footer_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: CSizes.lg * 4,
            left: CSizes.lg,
            right: CSizes.lg,
            bottom: CSizes.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headers
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.spaceBtwitems),
              Text(
                'Sign in to continue to Campus Pulse',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              // Email Field
              Text(
                'Email',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: CColors.black),
              ),
              const SizedBox(height: CSizes.sm),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwitems),
              // Password Field
              Text(
                'Password',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: CColors.black),
              ),
              const SizedBox(height: CSizes.sm),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.password_rounded),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => NavigationMenu()),
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwitems),
              // Don't have an Account
              AuthFooterText(
                footText: CTexts.dontHaveAnaccount,
                authText: CTexts.signUp,
                onPressed: () => Get.to(() => RegisterScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
