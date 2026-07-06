import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  // Neo Brutalism hard shadow
  static const BoxShadow hard = BoxShadow(
    color: AppColors.black,
    offset: Offset(4, 4),
    blurRadius: 0,
    spreadRadius: 0,
  );

  // Large shadow for primary cards
  static const BoxShadow large = BoxShadow(
    color: AppColors.black,
    offset: Offset(6, 6),
    blurRadius: 0,
    spreadRadius: 0,
  );
  
  // Pressed state (no shadow)
  static const BoxShadow pressed = BoxShadow(
    color: AppColors.transparent,
    offset: Offset(0, 0),
    blurRadius: 0,
    spreadRadius: 0,
  );
}
