import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({Key? key, this.text = 'OR'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: theme.border, thickness: 2.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: AppTypography.caption.copyWith(
                color: theme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: theme.border, thickness: 2.0),
          ),
        ],
      ),
    );
  }
}
