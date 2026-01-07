import 'package:campuspulse/features/auth/screens/onboarding/onboarding.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      home: const Scaffold(
        backgroundColor: CColors.primary,
        body: OnboardingScreen(),
      ),
    );
  }
}
