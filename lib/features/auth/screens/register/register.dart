import 'package:campuspulse/features/auth/screens/login/login.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/constants/text_strings.dart';
import 'package:campuspulse/widgets/auth_footer_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title and SubTitle
              Text(
                "Let's Start",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.sm),
              Text(
                "Sign Up to continue your journey in campus Pulse",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              // Form
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CTexts.username,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: CColors.black),
                    ),
                    const SizedBox(height: CSizes.sm),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Enter your Full Name ",
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtwitems),
                    Text(
                      CTexts.email,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: CColors.black),
                    ),
                    const SizedBox(height: CSizes.sm),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Enter your Email",
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtwitems),
                    Text(
                      CTexts.password,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: CColors.black),
                    ),
                    const SizedBox(height: CSizes.sm),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.password_outlined),
                        hintText: "Enter your Password ",
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtwitems),
                    Text(
                      CTexts.confirmPassword,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: CColors.black),
                    ),
                    const SizedBox(height: CSizes.sm),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.password_outlined),

                        hintText: "Confrim your Password ",
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtwSections),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          CTexts.signUp,
                          style: TextStyle(color: CColors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtwitems),

                    AuthFooterText(
                      footText: CTexts.alreadyHaveAnaccount,
                      authText: CTexts.signIn,
                      onPressed: () => Get.to(() => LoginScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
