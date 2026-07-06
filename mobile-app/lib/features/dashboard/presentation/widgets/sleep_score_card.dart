import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../data/models/dashboard_models.dart';

class SleepScoreCard extends StatelessWidget {
  final SleepStatistics stats;

  const SleepScoreCard({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: NeoCard(
        backgroundColor: theme.primary,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '😴 SLEEP SCORE',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                Icon(Icons.stars, color: Colors.yellowAccent, size: 24),
              ],
            ),
            const SizedBox(height: 32),
            
            // Hero Progress Ring
            ProgressRing(
              score: stats.sleepScore.toDouble(),
              size: 160.0,
              strokeWidth: 16.0,
            ),
            
            const SizedBox(height: 32),
            
            // Quality Text
            Text(
              stats.quality,
              style: AppTypography.heading1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            
            // Motivational Quote
            Text(
              '"${stats.motivationalText}"',
              style: AppTypography.body.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
