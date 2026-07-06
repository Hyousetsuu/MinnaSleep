import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';

class FormSection extends StatelessWidget {
  final String label;
  final Widget child;

  const FormSection({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: theme.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
