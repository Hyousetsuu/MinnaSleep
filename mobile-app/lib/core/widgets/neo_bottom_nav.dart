import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NeoBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NeoBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.background,
        border: Border(top: theme.defaultBorderSide),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, LucideIcons.layoutDashboard, 'Dashboard'),
              _buildNavItem(context, 1, LucideIcons.history, 'History'),
              _buildNavItem(context, 2, LucideIcons.barChart2, 'Analytics'),
              _buildNavItem(context, 3, LucideIcons.users, 'Community'),
              _buildNavItem(context, 4, LucideIcons.user, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: isSelected
            ? BoxDecoration(
                color: theme.surface,
                border: Border.fromBorderSide(theme.defaultBorderSide),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [theme.defaultShadow],
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? theme.primary : theme.textSecondary,
              size: 28,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textPrimary,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
