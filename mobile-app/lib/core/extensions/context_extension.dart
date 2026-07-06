import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  
  NeoThemeExtension get neoTheme => Theme.of(this).extension<NeoThemeExtension>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;
}
