import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import 'neo_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final String? emoji;

  const EmptyState({
    Key? key,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
    this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (emoji != null) ...[
              Text(
                emoji!,
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              style: AppTypography.heading2.copyWith(color: theme.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTypography.body.copyWith(color: theme.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 32),
              NeoButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
