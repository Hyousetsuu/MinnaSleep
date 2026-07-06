import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

class NeoThemeExtension extends ThemeExtension<NeoThemeExtension> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  
  final BorderSide defaultBorderSide;
  final BoxShadow defaultShadow;

  const NeoThemeExtension({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.defaultBorderSide,
    required this.defaultShadow,
  });

  @override
  ThemeExtension<NeoThemeExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    BorderSide? defaultBorderSide,
    BoxShadow? defaultShadow,
  }) {
    return NeoThemeExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      defaultBorderSide: defaultBorderSide ?? this.defaultBorderSide,
      defaultShadow: defaultShadow ?? this.defaultShadow,
    );
  }

  @override
  ThemeExtension<NeoThemeExtension> lerp(
      covariant ThemeExtension<NeoThemeExtension>? other, double t) {
    if (other is! NeoThemeExtension) return this;
    return NeoThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      defaultBorderSide: BorderSide.lerp(defaultBorderSide, other.defaultBorderSide, t),
      defaultShadow: BoxShadow.lerp(defaultShadow, other.defaultShadow, t)!,
    );
  }

  // Light Theme Tokens
  static const NeoThemeExtension light = NeoThemeExtension(
    primary: AppColors.purple,
    secondary: AppColors.magentaPurple,
    background: AppColors.white,
    surface: AppColors.lightGray,
    textPrimary: AppColors.black,
    textSecondary: AppColors.deepNavy,
    border: AppColors.black,
    defaultBorderSide: AppBorders.defaultSide,
    defaultShadow: AppShadows.hard,
  );

  // Dark Theme Tokens (Default for Neo Brutalism Minna Sleep)
  static const NeoThemeExtension dark = NeoThemeExtension(
    primary: AppColors.purple,
    secondary: AppColors.magentaPurple,
    background: AppColors.deepNavy,
    surface: AppColors.white, // Surface cards are light gray/white in dark mode neo brutalism
    textPrimary: AppColors.white,
    textSecondary: AppColors.lightGray,
    border: AppColors.black,
    defaultBorderSide: AppBorders.defaultSide,
    defaultShadow: AppShadows.hard,
  );
}
