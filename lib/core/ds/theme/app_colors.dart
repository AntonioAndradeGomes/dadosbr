import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const Color backgroundLight = Color(0xFFF5F7F5);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundCardHover = Color(0xFFF0F5F1);

  // Primary — Verde Bandeira do Brasil
  static const Color primaryGreen = Color(0xFF009C3B);
  static const Color primaryGreenLight = Color(0xFF33B361);
  static const Color primaryGreenDark = Color(0xFF007A2E);

  // Texts
  static const Color textPrimary = Color(0xFF0D1F14);
  static const Color textSecondary = Color(0xFF4B5E52);
  static const Color textTertiary = Color(0xFF8FA396);

  // Borders
  static const Color borderColor = Color(0xFFDDE5DF);
  static const Color borderColorLight = Color(0xFFEEF3EF);

  // Status
  static const Color statusSuccess = Color(0xFF009C3B);
  static const Color statusWarning = Color(0xFFF59E0B);
  static const Color statusError = Color(0xFFDC2626);
  static const Color statusInfo = Color(0xFF2563EB);

  // Charts
  static const Color chartPrimary = Color(0xFF009C3B);
  static const Color chartSecondary = Color(0xFFFFDF00); // amarelo da bandeira
  static const Color chartTertiary = Color(0xFF1E3A5F); // azul da esfera

  // Gradients
  static const LinearGradient greenGradient = LinearGradient(
    colors: [primaryGreen, primaryGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows — mais suaves no light theme
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 6)),
  ];
}
