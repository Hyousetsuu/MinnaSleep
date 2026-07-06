import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../data/models/dashboard_models.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TodaySleepCard extends StatelessWidget {
  final SleepStatistics stats;

  const TodaySleepCard({Key? key, required this.stats}) : super(key: key);

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    final progressPercentage = (stats.durationMinutes / stats.goalMinutes).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: NeoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.moon, color: theme.textPrimary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'TODAY\'S SLEEP',
                  style: TextStyle(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(theme, 'Bedtime', _formatTime(stats.bedtime), LucideIcons.bed),
                _buildTimeColumn(theme, 'Duration', _formatDuration(stats.durationMinutes), LucideIcons.clock),
                _buildTimeColumn(theme, 'Wake Up', _formatTime(stats.wakeTime), LucideIcons.sun),
              ],
            ),
            const SizedBox(height: 24),
            
            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sleep Goal: ${_formatDuration(stats.goalMinutes)}',
                  style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  '${(progressPercentage * 100).toInt()}%',
                  style: TextStyle(color: theme.primary, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.background,
                border: Border.all(color: theme.border, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progressPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: BorderRadius.circular(6),
                    border: Border(right: BorderSide(color: theme.border, width: 2)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(NeoThemeExtension theme, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: theme.textSecondary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTypography.title.copyWith(color: theme.textPrimary, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: theme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
