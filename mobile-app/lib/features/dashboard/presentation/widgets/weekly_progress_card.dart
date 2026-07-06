import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../data/models/dashboard_models.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WeeklyProgressCard extends StatelessWidget {
  final List<DailyProgress> weeklyData;

  const WeeklyProgressCard({Key? key, required this.weeklyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: NeoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.barChart2, color: theme.textPrimary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'WEEKLY PROGRESS',
                  style: TextStyle(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: weeklyData.map((data) {
                  final fillPercent = (data.durationMinutes / data.goalMinutes).clamp(0.0, 1.0);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // The Bar
                      Container(
                        width: 24,
                        height: 120, // max height
                        decoration: BoxDecoration(
                          color: theme.background,
                          border: Border.all(color: theme.border, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: fillPercent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: fillPercent >= 1.0 ? theme.success : theme.primary,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                              ),
                              border: Border(top: BorderSide(color: theme.border, width: 2)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Day Label
                      Text(
                        data.dayName,
                        style: TextStyle(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
