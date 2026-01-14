import 'package:campuspulse/features/auth/controllers/signup_controller/signup_controller.dart';
import 'package:campuspulse/features/auth/screens/login/login.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/constants/text_strings.dart';
import 'package:campuspulse/utils/validator/validation.dart';
import 'package:campuspulse/widgets/auth_footer_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title and SubTitle
              Text(
                "Let's Started",
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
                key: controller.signupFormKey,
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
                      controller: controller.userName,
                      validator: (value) =>
                          CValidator.validatetextfield(value, 'UserName'),
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
                      controller: controller.email,
                      validator: (value) => CValidator.validateEmail(value),
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
                    Obx(
                      () => TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.password,
                        validator: (value) =>
                            CValidator.validatePassword(value),
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                controller.hideconfirmPassword.value =
                                    !controller.hideconfirmPassword.value,
                            icon: Icon(
                              controller.hideconfirmPassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                            ),
                          ),
                        ),
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
                    Obx(
                      () => TextFormField(
                        obscureText: controller.hideconfirmPassword.value,
                        controller: controller.confrimPassword,
                        validator: (value) =>
                            CValidator.validatePassword(value),
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: CSizes.spaceBtwSections),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.signup(),
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
