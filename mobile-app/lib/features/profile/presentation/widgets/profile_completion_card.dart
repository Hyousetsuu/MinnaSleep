import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileCompletionCard extends StatelessWidget {
  final ProfileEntity profile;
  
  const ProfileCompletionCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.isCompleted) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.neoBox(color: AppColors.secondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('👋 Welcome!', style: AppTypography.h3),
          const SizedBox(height: 8),
          Text(
            'Your profile is only ${profile.completionPercentage.toInt()}% complete.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),
          _buildTaskItem('Upload Avatar', profile.avatarUrl != null),
          _buildTaskItem('Set Username', profile.username.isNotEmpty),
          _buildTaskItem('Write a Bio', profile.bio != null && profile.bio!.isNotEmpty),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to Edit Profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.text,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: AppColors.text, width: 3),
              ),
            ),
            child: const Text('Complete Profile', style: AppTypography.button),
          )
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: AppColors.text,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTypography.bodySmall.copyWith(
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
