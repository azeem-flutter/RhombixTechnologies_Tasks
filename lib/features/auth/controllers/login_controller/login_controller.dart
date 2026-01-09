import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/utils/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Variables

  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  // Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    // Helper: open loader
    void showLoader() {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }

    // Helper: close loader
    void hideLoader() {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }

    try {
      // Start Loading
      showLoader();

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        hideLoader();
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(const SnackBar(content: Text('No internet connection')));
        return;
      }

      // Validate Form
      if (!loginKey.currentState!.validate()) {
        hideLoader();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Please enter valid email & password')),
        );
        return;
      }

      // Login user
      await AuthenticationRepository.instance.signInWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Stop loading
      hideLoader();

      // Redirect
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
