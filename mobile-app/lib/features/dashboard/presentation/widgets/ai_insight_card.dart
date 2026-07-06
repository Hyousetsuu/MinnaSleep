import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../data/models/dashboard_models.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AIInsightCard extends StatelessWidget {
  final AIInsight insight;

  const AIInsightCard({Key? key, required this.insight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: NeoCard(
        backgroundColor: theme.secondary, // Magenta purple background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🤖', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'AI INSIGHT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                if (!insight.isAvailable) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.background,
                      border: Border.all(color: theme.border, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: theme.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              insight.isAvailable
                  ? '"${insight.message}"'
                  : 'Unlock AI Sleep Coach to get personalized insights about your sleep patterns.',
              style: AppTypography.body.copyWith(
                color: Colors.white,
                fontStyle: insight.isAvailable ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            
            if (!insight.isAvailable) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Navigate to Premium
                },
                child: Row(
                  children: [
                    Text(
                      'Upgrade Now',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.yellowAccent,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(LucideIcons.arrowRight, color: Colors.yellowAccent, size: 16),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
