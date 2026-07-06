import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';

class NeoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? emoji;
  final List<Widget>? actions;

  const NeoAppBar({
    Key? key,
    required this.title,
    this.emoji,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.background,
        border: Border(
          bottom: theme.defaultBorderSide,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.title.copyWith(color: theme.textPrimary),
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
