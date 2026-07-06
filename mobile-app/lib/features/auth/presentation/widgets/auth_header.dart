import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? emoji;

  const AuthHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (emoji != null) ...[
          Text(emoji!, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          style: AppTypography.display.copyWith(
            color: theme.textPrimary,
            fontSize: 40.0,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: AppTypography.body.copyWith(
              color: theme.textSecondary,
              fontSize: 18.0,
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}
