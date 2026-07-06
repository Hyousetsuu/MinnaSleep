import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../data/models/dashboard_models.dart';
import 'package:intl/intl.dart';

class RecentSleepCard extends StatelessWidget {
  final RecentActivity activity;
  final VoidCallback onTap;

  const RecentSleepCard({
    Key? key, 
    required this.activity,
    required this.onTap,
  }) : super(key: key);

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final dateStr = DateFormat('EEE, MMM d').format(activity.date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: NeoCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Emoji Mood
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: theme.border, width: 2),
              ),
              child: Text(activity.mood, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateStr,
                    style: TextStyle(
                      color: theme.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(activity.durationMinutes),
                    style: AppTypography.title.copyWith(color: theme.textPrimary),
                  ),
                ],
              ),
            ),
            
            // Score badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.secondary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.border, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    '${activity.sleepScore}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'SCORE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
