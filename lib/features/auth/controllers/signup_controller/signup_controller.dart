import 'package:campuspulse/features/notification/models/user_model.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/services/user_repository.dart';
import 'package:campuspulse/utils/network/network_manager.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final hideconfirmPassword = true.obs;
  final email = TextEditingController();

  final userName = TextEditingController();

  final password = TextEditingController();
  final confrimPassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  //Signup
  Future<void> signup() async {
    void showLoader() {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }

    void hideLoader() {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }

    try {
      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(const SnackBar(content: Text('No Internet Connection')));
        return;
      }

      // Validate form BEFORE showing loader
      if (!signupFormKey.currentState!.validate()) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(const SnackBar(content: Text('Invalid input')));
        return;
      }

      // Confirm password check
      if (password.text.trim() != confrimPassword.text.trim()) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
        return;
      }

      // Validation passed — now show loader
      showLoader();

      // Firebase Auth Signup
      final userCredential = await AuthenticationRepository.instance
          .signUpWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save user
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        username: userName.text.trim(),
      );

      await Get.put(UserRepository()).saveUserRecord(newUser);

      hideLoader();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Ensure loader is hidden
      hideLoader();
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      // Double-check loader is hidden
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
