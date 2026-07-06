import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.purple,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      extensions: const [
        NeoThemeExtension.light,
      ],
      // Override material components to have neo brutalism feel if necessary
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepNavy,
      primaryColor: AppColors.purple,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      extensions: const [
        NeoThemeExtension.dark,
      ],
    );
  }
}
