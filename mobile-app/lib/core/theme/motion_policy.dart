import 'package:flutter/material.dart';

/// Defines the intensity of motion in the application.
enum MotionPreset {
  /// Standard Neo Brutalism animations (Bounce, Hero, Scale, Slide).
  normal,

  /// Accessibility-first animations (Fade 100ms) for users sensitive to motion.
  reduced,

  /// No animation at all (Instant cut). Reserved for critical system transitions
  /// like Splash -> Home, Theme switches, and Language changes.
  instant,
}

/// A centralized policy for resolving animations based on User OS Preferences.
class MotionPolicy {
  final BuildContext context;
  
  MotionPolicy(this.context);

  /// Resolves the current motion preference from the OS via MediaQuery.
  MotionPreset get currentPreset {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    return disableAnimations ? MotionPreset.reduced : MotionPreset.normal;
  }

  /// Builds a transition wrapper based on the motion policy.
  /// 
  /// If [MotionPreset.normal] is active, the [normalBuilder] is used (e.g. Scale, Hero).
  /// If [MotionPreset.reduced] is active, it enforces a 100ms Fade instead.
  /// 
  /// Set [forceInstant] to true for exceptions like Theme changes or Splash screens.
  Widget buildTransition({
    required Widget child,
    required Widget Function(BuildContext context, Widget child) normalBuilder,
    bool forceInstant = false,
  }) {
    if (forceInstant) {
      return child; // Instant cut, no animation
    }

    final preset = currentPreset;
    
    if (preset == MotionPreset.reduced) {
      // Force 100ms Fade for reduced motion preference
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        child: child,
      );
    }

    // Default to normal rich animations (Scale, Bounce, Slide, Hero)
    return normalBuilder(context, child);
  }

  /// Standard duration for normal animations
  Duration get normalDuration => const Duration(milliseconds: 300);

  /// Restricted duration when reduced motion is enabled
  Duration get reducedDuration => const Duration(milliseconds: 100);

  /// Resolves the effective duration based on preference
  Duration get effectiveDuration {
    return currentPreset == MotionPreset.reduced ? reducedDuration : normalDuration;
  }
}
