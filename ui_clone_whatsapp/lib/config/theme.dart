import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF075E54);
  static const Color accentColor = Color(0xFF128C7E);
  static const Color lightGreen = Color(0xFF25D366);
  static const Color chatBubbleLight = Color(0xFFE8E8E8);
  static const Color chatBubbleDark = Color(0xFFDCF8C6);
  
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightGreen,
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
