import 'package:campuspulse/app/app.dart';
import 'package:campuspulse/firebase_options.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Must be first
  WidgetsFlutterBinding.ensureInitialized();

  // Init GetStorage early
  await GetStorage.init();

  // Keep splash after binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Put Auth Repo AFTER firebase
  Get.put(AuthenticationRepository());

  // Launch app
  runApp(const App());

  // Remove splash manually (optional if you call it in repo)
  FlutterNativeSplash.remove();
}
