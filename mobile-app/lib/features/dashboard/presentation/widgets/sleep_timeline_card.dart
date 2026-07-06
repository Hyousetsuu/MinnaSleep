import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import '../../data/models/dashboard_models.dart';

class SleepTimelineCard extends StatelessWidget {
  final List<SleepTimelineEvent> events;

  const SleepTimelineCard({Key? key, required this.events}) : super(key: key);

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
                const Text('🌙', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'LAST NIGHT TIMELINE',
                  style: TextStyle(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Vertical Timeline
            ...List.generate(events.length, (index) {
              final event = events[index];
              final isLast = index == events.length - 1;
              
              return IntrinsicHeight(
                child: Row(
                  children: [
                    // Time text
                    SizedBox(
                      width: 50,
                      child: Text(
                        event.time,
                        style: TextStyle(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Vertical Line & Dot
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.border, width: 2),
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 3,
                              color: theme.border,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    
                    // Event Description
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0), // space between events
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.emoji, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                event.description,
                                style: AppTypography.body.copyWith(
                                  color: theme.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
