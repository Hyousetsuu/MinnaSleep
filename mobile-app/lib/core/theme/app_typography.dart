import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'SpaceGrotesk'; // Assuming Google Fonts 'Space Grotesk'

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w900, // Black
    fontSize: 56.0,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800, // ExtraBold
    fontSize: 32.0,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 24.0,
    height: 1.3,
  );
  
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700, // Bold
    fontSize: 20.0,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 16.0,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 14.0,
    height: 1.4,
  );
}
