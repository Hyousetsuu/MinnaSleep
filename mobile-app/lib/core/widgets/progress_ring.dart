import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import '../theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  final double score; // 0 to 100
  final double size;
  final double strokeWidth;

  const ProgressRing({
    Key? key,
    required this.score,
    this.size = 120.0,
    this.strokeWidth = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    // Determine color based on score
    Color ringColor = AppColors.success;
    if (score < 60) ringColor = AppColors.error;
    else if (score < 80) ringColor = AppColors.warning;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring (thick border)
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.border,
                width: 3.0, // Base neo brutalism border
              ),
              color: theme.surface,
              boxShadow: [theme.defaultShadow],
            ),
          ),
          
          // The actual progress indicator
          SizedBox(
            width: size - 6, // account for outer border
            height: size - 6,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: strokeWidth,
              backgroundColor: theme.surface, // transparent essentially
              color: ringColor,
              strokeCap: StrokeCap.square,
            ),
          ),
          
          // The oversized score
          Text(
            score.toInt().toString(),
            style: AppTypography.display.copyWith(
              fontSize: size * 0.35,
              color: theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
