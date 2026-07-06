import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum SyncStatus { synced, uploading, pending, conflict, failed }

class SyncStatusIndicator extends StatelessWidget {
  final SyncStatus status;

  const SyncStatusIndicator({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    IconData icon;
    Color color;

    switch (status) {
      case SyncStatus.synced:
        icon = LucideIcons.check;
        color = theme.success;
        break;
      case SyncStatus.uploading:
        icon = LucideIcons.cloudLightning;
        color = theme.primary;
        break;
      case SyncStatus.pending:
        icon = LucideIcons.clock;
        color = theme.textSecondary;
        break;
      case SyncStatus.conflict:
        icon = LucideIcons.alertTriangle;
        color = theme.warning;
        break;
      case SyncStatus.failed:
        icon = LucideIcons.xOctagon;
        color = theme.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 12, color: color),
    );
  }
}
