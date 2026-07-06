import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';

class FeedbackService {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, isError: false);
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, isError: true);
  }

  static void showWarning(BuildContext context, String message) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    _showCustomSnackBar(context, message, theme.warning, Colors.black);
  }

  static void showInfo(BuildContext context, String message) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    _showCustomSnackBar(context, message, theme.surface, theme.textPrimary);
  }

  static void _showSnackBar(BuildContext context, String message, {required bool isError}) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    _showCustomSnackBar(
      context,
      message,
      isError ? theme.error : theme.success,
      Colors.white,
    );
  }

  static void _showCustomSnackBar(BuildContext context, String message, Color bgColor, Color textColor) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: theme.border, width: 2),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
