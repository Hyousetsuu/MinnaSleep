import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import 'neo_button.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isOffline;

  const ErrorState({
    Key? key,
    required this.message,
    this.onRetry,
    this.isOffline = false,
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
            Text(
              isOffline ? '🔌' : '⚠️',
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 24),
            Text(
              isOffline ? 'No Internet Connection' : 'Oops, Something Went Wrong',
              style: AppTypography.heading2.copyWith(color: theme.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: AppTypography.body.copyWith(color: theme.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              NeoButton(
                text: 'Retry',
                onPressed: onRetry!,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
