import 'xp_entity.dart';

class ProfileEntity {
  final String id;
  final String userId;
  final String username;
  final String? avatarUrl;
  final String? bio;
  final int currentStreak;
  final int longestStreak;
  final XpEntity xp;

  const ProfileEntity({
    required this.id,
    required this.userId,
    required this.username,
    this.avatarUrl,
    this.bio,
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.xp,
  });

  bool get isCompleted => completionPercentage >= 100.0;

  double get completionPercentage {
    double completion = 0.0;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) completion += 20.0;
    if (username.isNotEmpty) completion += 20.0;
    if (bio != null && bio!.isNotEmpty) completion += 20.0;
    // Assume Sleep Goal and Notification are part of SettingsEntity, but for Profile context:
    // We add base 40% if the profile is just created as a starting point,
    // or calculate from other sources later. For now, strict parts:
    completion += 40.0; // Mocked default settings (Goal 20%, Notification 20%)
    return completion;
  }
}
