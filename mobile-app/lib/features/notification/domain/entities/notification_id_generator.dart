class NotificationIdGenerator {
  static String generate() {
    final now = DateTime.now();
    final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final micro = now.microsecond.toString().padLeft(6, '0');
    return 'ntf_${timestamp}_$micro';
  }
}
