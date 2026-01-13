import 'package:campuspulse/features/auth/models/user_model.dart';
import 'package:campuspulse/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    isDarkMode.value = Get.isDarkMode;
  }

  // Fetch User Records

  Future<void> fetchUserRecord() async {
    try {
      final user = await UserRepository.instance.fetchUserDetails();

      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
