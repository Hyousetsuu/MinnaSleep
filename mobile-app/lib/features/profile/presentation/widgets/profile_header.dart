import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  
  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.neoBox(color: AppColors.surface),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${profile.username}',
                  style: AppTypography.h3,
                ),
                const SizedBox(height: 4),
                Text(
                  profile.bio ?? 'No bio yet.',
                  style: AppTypography.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildStreakBadge(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: AppDecorations.neoBox(color: AppColors.primary),
      child: Center(
        child: profile.avatarUrl != null 
          ? Image.network(profile.avatarUrl!)
          : const Icon(Icons.person, size: 40, color: AppColors.text),
      ),
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: AppDecorations.neoBox(color: AppColors.warning),
      child: Column(
        children: [
          const Icon(Icons.local_fire_department, color: AppColors.text),
          const SizedBox(height: 4),
          Text('${profile.currentStreak}', style: AppTypography.h2),
        ],
      ),
    );
  }
}
