import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DailyChart extends StatelessWidget {
  const DailyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return NeoCard(
      padding: const EdgeInsets.all(24.0),
      backgroundColor: theme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SLEEP DEBT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              Icon(LucideIcons.alertTriangle, color: Colors.yellowAccent),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                '-2h 15m',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'You are accumulating sleep debt this week.',
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
