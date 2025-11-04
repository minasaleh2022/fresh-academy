import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppTypography {
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textDark),
    bodySmall:   TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textLight),
    labelSmall:  TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textLight),
  );
}
