class UserEntity {
  final String id;
  final String email;
  final String username;
  final String displayName;
  final String avatarUrl;
  final String? bio;
  final int currentStreak;
  final int longestStreak;
  final int xp;
  final bool isPremium;
  final DateTime joinDate;
  final DateTime updatedAt;
  final int version;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    this.avatarUrl = '',
    this.bio,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.xp = 0,
    this.isPremium = false,
    required this.joinDate,
    required this.updatedAt,
    this.version = 1,
  });
}
