import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    Key? key,
    required this.password,
  }) : super(key: key);

  int _calculateStrength() {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$&*~]'))) score++;
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength();
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    Color getColor() {
      if (strength == 0) return theme.border;
      if (strength <= 1) return AppColors.error;
      if (strength <= 2) return AppColors.warning;
      if (strength <= 3) return AppColors.info;
      return AppColors.success;
    }

    String getText() {
      if (strength == 0) return 'Very Weak';
      if (strength <= 1) return 'Weak';
      if (strength <= 2) return 'Fair';
      if (strength <= 3) return 'Good';
      return 'Strong';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 8,
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: index < strength ? getColor() : theme.surface,
                      border: Border.all(color: theme.border, width: 2),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            getText(),
            style: TextStyle(
              color: theme.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
