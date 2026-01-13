import 'package:campuspulse/app/app.dart';
import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/firebase_options.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/services/notification_reponsitory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // Must be first
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezones
  tz.initializeTimeZones();

  // Init GetStorage early
  await GetStorage.init();

  // Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Put Auth Repo AFTER firebase
  Get.put(AuthenticationRepository());
  // Get.put(NotificationController()); // Moved to NavigationMenu

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

  runApp(const App());
}
