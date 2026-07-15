// Sprint 19: Animation Tokens
// Universal animation durations and curves for widgets.

class AnimationTokens {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const String spring = 'spring_curve';
  static const String bounce = 'bounce_curve';
  
  static void logTokens() {
    print("[AnimationTokens] Ready to provide universal physics.");
  }
}
