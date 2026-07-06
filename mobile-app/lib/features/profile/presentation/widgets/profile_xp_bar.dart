import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../domain/entities/xp_entity.dart';

class ProfileXpBar extends StatelessWidget {
  final XpEntity xp;

  const ProfileXpBar({super.key, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Level ${xp.level}', style: AppTypography.h3),
            Text('${xp.currentXp} / ${xp.xpForNextLevel} XP', style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 24,
          width: double.infinity,
          decoration: AppDecorations.neoBox(color: AppColors.surface),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * xp.levelProgress,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: const Border(
                        right: BorderSide(color: AppColors.text, width: 3),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${xp.xpRemaining} XP to Level ${xp.level + 1}',
          style: AppTypography.caption,
        ),
      ],
    );
  }
}
