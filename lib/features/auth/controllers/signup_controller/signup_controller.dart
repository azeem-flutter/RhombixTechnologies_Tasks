import 'package:campuspulse/features/auth/models/user_model.dart';
import 'package:campuspulse/features/auth/screens/login/login.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/services/user_repository.dart';
import 'package:campuspulse/utils/constants/image_string.dart';
import 'package:campuspulse/utils/loader/full_screen_loader.dart';
import 'package:campuspulse/utils/loader/loader.dart';
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
    try {
      //Start Loading
      CFullScreenLoader.openLoadingDialog(
        'we are processing your information',
        CImageString.loader,
      );
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }
      // Confirm Password
      if (password.text.trim() != confrimPassword.text.trim()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // Firebase Auth Signup
      final userCredential = await AuthenticationRepository.instance
          .signUpWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save user
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        username: userName.text.trim(),
      );
      // Remove Loader
      CFullScreenLoader.stopLoading();
      await UserRepository.instance.saveUserRecord(newUser);
      // show Success Message
      CLoader.successSnackBar(
        title: 'Congratualations',
        message: 'Your account has been created.',
      );
      // Go to home screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
