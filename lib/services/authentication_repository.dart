import 'package:campuspulse/features/auth/screens/login/login.dart';
import 'package:campuspulse/features/auth/screens/onboarding/onboarding.dart';
import 'package:campuspulse/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = kIsWeb ? null : GetStorage();
  final _auth = FirebaseAuth.instance;

  // For web fallback
  bool _isFirstTimeWeb = true;

  // Get Authentication User data

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    // screenRedirect() is now handled by SplashScreen
  }

  // Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => const NavigationMenu());
    } else {
      // Local Storage
      if (kIsWeb) {
        if (_isFirstTimeWeb) {
          _isFirstTimeWeb = false;
          Get.offAll(const OnboardingScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      } else {
        try {
          deviceStorage!.writeIfNull('isFirstTime', true);
          deviceStorage!.read('isFirstTime') != true
              ? Get.offAll(() => const LoginScreen())
              : Get.offAll(const OnboardingScreen());
        } catch (e) {
          Get.offAll(const OnboardingScreen());
        }
      }
    }
  }

  /* --------------------------------------------- Email & Password sign-in --------------------------------------- */

  // SignIn
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // SignUp
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //Sign Out
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
