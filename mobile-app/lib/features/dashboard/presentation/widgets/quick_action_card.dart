import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_radius.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QuickActionCard extends StatelessWidget {
  final VoidCallback onStartSleep;
  final VoidCallback onManualEntry;

  const QuickActionCard({
    Key? key,
    required this.onStartSleep,
    required this.onManualEntry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildActionBtn(
              context, 
              'Start Sleep', 
              LucideIcons.play, 
              true,
              onStartSleep,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionBtn(
              context, 
              'Manual Entry', 
              LucideIcons.penTool, 
              false,
              onManualEntry,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, String text, IconData icon, bool isPrimary, VoidCallback onTap) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: isPrimary ? theme.primary : theme.surface,
          border: Border.all(color: theme.border, width: 3),
          borderRadius: AppRadius.borderMd,
          boxShadow: [theme.defaultShadow],
        ),
        child: Column(
          children: [
            Icon(
              icon, 
              color: isPrimary ? Colors.white : theme.textPrimary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.white : theme.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
