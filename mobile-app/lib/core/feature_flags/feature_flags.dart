class FeatureFlags {
  // Feature flags allow toggling features on and off without code changes
  // Useful for phased rollouts, testing, and managing premium features
  
  static const bool enableAI = false;
  static const bool enablePremium = false;
  static const bool enableCommunity = false;
  static const bool enableChallenges = false;
  static const bool enableLeaderboard = false;
  static const bool enableAdmin = false;
  
  // Dashboard specific
  static const bool showFriendsActivity = false;
  static const bool showWeeklyProgress = true;
}
