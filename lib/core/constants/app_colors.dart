import 'package:flutter/material.dart';

// Modern color system - tab-specific gradients with dark/light support
class AppColors {
  // Dark backgrounds
  static const Color darkBg = Color(0xFF0F1923);
  static const Color darkSurface = Color(0xFF1A2535);
  static const Color darkCard = Color(0xFF1E2D42);
  static const Color darkBorder = Color(0xFF2A3F5A);

  // Light backgrounds
  static const Color lightBg = Color(0xFFF0F4FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE8EDF5);

  // Text
  static const Color darkText = Color(0xFFE8EFF8);
  static const Color darkTextSecondary = Color(0xFF7A96B8);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Tab gradients
  static const List<Color> aboutGradient = [
    Color(0xFF22C55E),
    Color(0xFF16A34A),
  ];
  static const List<Color> projectsGradient = [
    Color(0xFF818CF8),
    Color(0xFF6366F1),
  ];
  static const List<Color> contactGradient = [
    Color(0xFFFBBF24),
    Color(0xFFF59E0B),
  ];
}
