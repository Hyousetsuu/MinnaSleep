enum FeatureFlag {
  ai,
  premium,
  community,
  leaderboard,
  analyticsV2,
}

class FeatureToggleService {
  static final Map<FeatureFlag, bool> _flags = {
    FeatureFlag.ai: false,
    FeatureFlag.premium: true,
    FeatureFlag.community: false,
    FeatureFlag.leaderboard: false,
    FeatureFlag.analyticsV2: true,
  };

  static bool isEnabled(FeatureFlag flag) {
    return _flags[flag] ?? false;
  }
}
