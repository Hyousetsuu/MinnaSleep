import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HistoryDailyList extends StatelessWidget {
  final List<dynamic> sessions; // Mock data
  final Function(String) onDelete;

  const HistoryDailyList({
    Key? key,
    required this.sessions,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        // Mock data logic
        final isDeleted = false; // Add real logic when hooked to Drift
        
        return Dismissible(
          key: ValueKey(index),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24.0),
            decoration: BoxDecoration(
              color: theme.error,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.border, width: 2),
            ),
            child: const Icon(LucideIcons.trash2, color: Colors.white, size: 32),
          ),
          onDismissed: (direction) => onDelete(index.toString()),
          child: NeoCard(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Score Box
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.border, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('8${index}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                      Text('SCORE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: theme.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yesterday, 22:30 - 06:45',
                        style: TextStyle(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '8h 15m',
                        style: AppTypography.heading2.copyWith(color: theme.textPrimary),
                      ),
                    ],
                  ),
                ),
                
                // Mood Emoji
                const Text('😎', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        );
      },
    );
  }
}
