import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/utils/constants/image_string.dart';
import 'package:campuspulse/utils/loader/full_screen_loader.dart';
import 'package:campuspulse/utils/loader/loader.dart';
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
    try {
      // Start Loading
      CFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        CImageString.loader,
      );
      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!loginKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }
      // Login user
      await AuthenticationRepository.instance.signInWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      // Remove Loader
      CFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
