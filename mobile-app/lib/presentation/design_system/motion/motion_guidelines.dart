// Sprint 19: Motion Guidelines
// Centralized physics and animation definitions to ensure the app feels native and grounded.

class MotionGuidelines {
  
  static const Duration fastTransition = Duration(milliseconds: 200);
  static const Duration smoothTransition = Duration(milliseconds: 350);

  // Example: Spring physics for bouncy, organic movements
  static const double springDamping = 0.8;
  static const double springStiffness = 250.0;
  
  static void applyStandardEasing() {
    print("Using standard curve for most UI transitions.");
  }
}
