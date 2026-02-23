import 'package:dadosbr/core/ds/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.primaryGreenLight,
        surface: AppColors.primaryGreenDark,
        surfaceContainerLowest: AppColors.primaryGreenDark,
        surfaceContainerLow: AppColors.backgroundCard, // Cards elevados
        surfaceContainer: AppColors.backgroundCard,
        surfaceContainerHigh: AppColors.backgroundCardHover,
        surfaceContainerHighest: AppColors.backgroundCardHover,
        error: AppColors.statusError,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight, // Mesmo do scaffold
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundCardHover,
        contentTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white, // ← Texto sempre branco
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        actionTextColor: AppColors.primaryGreen,
      ),
    );
  }
}
