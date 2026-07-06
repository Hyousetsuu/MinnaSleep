import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_radius.dart';
import '../../data/models/dashboard_models.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GreetingHeader extends StatelessWidget {
  final UserOverview user;
  final VoidCallback onNotificationTap;

  const GreetingHeader({
    Key? key,
    required this.user,
    required this.onNotificationTap,
  }) : super(key: key);

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '🌅 Good Morning';
    if (hour < 17) return '☀️ Good Afternoon';
    if (hour < 20) return '🌇 Good Evening';
    return '🌙 Good Night';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: theme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: theme.border, width: 2),
              boxShadow: [theme.defaultShadow],
              image: user.avatarUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(user.avatarUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: user.avatarUrl.isEmpty
                ? Icon(LucideIcons.user, color: theme.textSecondary)
                : null,
          ),
          const SizedBox(width: 16),
          
          // Greeting & Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    color: theme.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  user.displayName,
                  style: AppTypography.heading2.copyWith(color: theme.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Streak Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: theme.secondary,
              borderRadius: AppRadius.borderRound,
              border: Border.all(color: theme.border, width: 2),
            ),
            child: Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  '${user.currentStreak}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Notification Button
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: theme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: theme.border, width: 2),
                boxShadow: [theme.defaultShadow],
              ),
              child: Icon(LucideIcons.bell, color: theme.textPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
