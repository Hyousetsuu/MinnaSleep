class BatteryService {
  bool _isCharging = false;
  int _batteryLevel = 100;

  bool get isCharging => _isCharging;
  int get batteryLevel => _batteryLevel;

  void startListening() {
    // use battery_plus plugin here
  }

  void stopListening() {
    
  }
}
