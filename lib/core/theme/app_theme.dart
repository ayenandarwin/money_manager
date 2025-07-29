import 'package:flutter/material.dart';
import 'package:money_manager_app/core/constants/app_color.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
        AppColors.primaryBackground, // မှောင်တဲ့ background အရောင်
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.secondaryText),
      titleTextStyle: TextStyle(
        color: AppColors.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText),
      bodyMedium: TextStyle(color: AppColors.secondaryText),
      headlineSmall: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentColor, // '+' button အရောင်
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.bottomNavBackground,
      selectedItemColor: AppColors.accentColor,
      unselectedItemColor: AppColors.secondaryText,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    ),
    // အခြား Colors တွေ Fonts တွေ ထပ်ထည့်နိုင်ပါတယ်။
  );
}
