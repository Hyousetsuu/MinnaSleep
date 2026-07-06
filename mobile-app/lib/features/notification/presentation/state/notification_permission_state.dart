class NotificationPermissionState {
  final bool isGranted;
  final bool isDenied;
  final bool isPermanentlyDenied;
 
  const NotificationPermissionState({
    this.isGranted = false,
    this.isDenied = false,
    this.isPermanentlyDenied = false,
  });
}

class NotificationChannelConfig {
  final String id;
  final String name;
  final String description;
  final bool playSound;
  final bool enableVibration;
  final int importance; // e.g. 5 for Max

  const NotificationChannelConfig({
    required this.id,
    required this.name,
    required this.description,
    this.playSound = true,
    this.enableVibration = true,
    this.importance = 3, // Default
  });
}
