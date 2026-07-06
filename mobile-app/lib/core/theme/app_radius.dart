import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double round = 999.0;
  
  static final BorderRadius borderSm = BorderRadius.circular(sm);
  static final BorderRadius borderMd = BorderRadius.circular(md);
  static final BorderRadius borderLg = BorderRadius.circular(lg);
  static final BorderRadius borderRound = BorderRadius.circular(round);
}

class AppBorders {
  static const double thin = 2.0;
  static const double defaultBorder = 3.0;
  static const double thick = 5.0;

  static const BorderSide defaultSide = BorderSide(
    color: AppColors.black,
    width: defaultBorder,
  );
  
  static const BorderSide thickSide = BorderSide(
    color: AppColors.black,
    width: thick,
  );
}
