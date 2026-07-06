import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';
import 'neo_button.dart';

class NeoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const NeoDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  }) : super(key: key);

  static Future<T?> show<T>(BuildContext context, {
    required String title,
    required String content,
    required String primaryButtonText,
    required VoidCallback onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: animation,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: NeoDialog(
              title: title,
              content: content,
              primaryButtonText: primaryButtonText,
              onPrimaryPressed: onPrimaryPressed,
              secondaryButtonText: secondaryButtonText,
              onSecondaryPressed: onSecondaryPressed,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.fromBorderSide(theme.defaultBorderSide),
        borderRadius: AppRadius.borderLg,
        boxShadow: [theme.defaultShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading2.copyWith(color: theme.textPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: AppTypography.body.copyWith(color: theme.textSecondary),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              if (secondaryButtonText != null && onSecondaryPressed != null) ...[
                Expanded(
                  child: NeoButton(
                    text: secondaryButtonText!,
                    onPressed: onSecondaryPressed!,
                    backgroundColor: theme.background,
                    textColor: theme.textPrimary,
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: NeoButton(
                  text: primaryButtonText,
                  onPressed: onPrimaryPressed,
                  isFullWidth: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
