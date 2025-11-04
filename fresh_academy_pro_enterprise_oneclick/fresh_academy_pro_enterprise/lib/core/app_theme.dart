import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primaryRed,
      secondary: AppColors.lightRed,
      background: AppColors.background,
      surface: AppColors.primaryWhite,
      error: Colors.red,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTypography.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryWhite,
      foregroundColor: AppColors.textDark,
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.primaryWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.primaryWhite,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(12),
    ),
  );
}
