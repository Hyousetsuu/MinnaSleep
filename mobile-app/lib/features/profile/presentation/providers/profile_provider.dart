import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/xp_entity.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileEntity>>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileEntity>> {
  ProfileNotifier() : super(const AsyncValue.loading()) {
    _loadMockData();
  }

  Future<void> _loadMockData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncValue.data(
      const ProfileEntity(
        id: 'prof_123',
        userId: 'usr_123',
        username: 'minna_sleeper',
        avatarUrl: null,
        bio: 'Sleep is the best meditation.',
        currentStreak: 5,
        longestStreak: 12,
        xp: XpEntity(currentXp: 450),
      ),
    );
  }
}
