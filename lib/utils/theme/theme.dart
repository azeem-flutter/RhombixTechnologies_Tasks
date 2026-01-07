import 'package:campuspulse/utils/theme/customtheme/elevated_button.dart';
import 'package:campuspulse/utils/theme/customtheme/text_theme.dart';
import 'package:campuspulse/utils/theme/customtheme/textfield_theme.dart';
import 'package:flutter/material.dart';

class CAppTheme {
  CAppTheme._();
  // Light App Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: CTextFieldTheme.lightInputDecorationTheme,
    textTheme: CTextTheme.lightTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
  );
  // Dark App Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: CTextFieldTheme.darkInputDecorationTheme,
    textTheme: CTextTheme.darkTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
