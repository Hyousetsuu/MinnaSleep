import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import 'neo_button.dart';

class NeoEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const NeoEmptyState({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
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
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: theme.border, width: 3),
                boxShadow: [theme.defaultShadow],
              ),
              child: Icon(icon, size: 48, color: theme.primary),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.heading2.copyWith(color: theme.textPrimary),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.textSecondary, fontSize: 16),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              NeoButton(
                text: actionLabel!,
                onPressed: onAction!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
