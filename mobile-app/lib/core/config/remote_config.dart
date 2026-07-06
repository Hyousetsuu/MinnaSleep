class RemoteConfig {
  RemoteConfig._privateConstructor();
  static final RemoteConfig instance = RemoteConfig._privateConstructor();

  // Simulated Remote Config values
  bool _isPremiumEnabled = true;
  bool _isAiEnabled = false;
  bool _isCommunityEnabled = true;
  bool _isMaintenanceMode = false;
  
  // AI Limits
  int _freeAiDailyLimit = 5;
  int _premiumAiDailyLimit = 100;

  Future<void> fetch() async {
    // Simulates fetching values from backend/Firebase Remote Config
    // _isPremiumEnabled = await ...
  }

  bool get isPremiumEnabled => _isPremiumEnabled;
  bool get isAiEnabled => _isAiEnabled;
  bool get isCommunityEnabled => _isCommunityEnabled;
  bool get isMaintenanceMode => _isMaintenanceMode;
  
  int get freeAiDailyLimit => _freeAiDailyLimit;
  int get premiumAiDailyLimit => _premiumAiDailyLimit;
}
