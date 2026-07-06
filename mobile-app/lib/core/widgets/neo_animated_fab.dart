import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_animations.dart';
import '../theme/motion_policy.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NeoAnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const NeoAnimatedFAB({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  State<NeoAnimatedFAB> createState() => _NeoAnimatedFABState();
}

class _NeoAnimatedFABState extends State<NeoAnimatedFAB> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppAnimations.fast);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    Future.delayed(AppAnimations.fast, () {
      widget.onPressed();
    });
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final motionPolicy = MotionPolicy(context);

    // If reduced motion is active, duration is automatically clamped to 100ms
    _controller.duration = motionPolicy.effectiveDuration;

    return Semantics(
      button: true,
      label: widget.label,
      hint: "Double tap to activate",
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: motionPolicy.buildTransition(
          child: _buildFabBody(theme),
          normalBuilder: (context, child) {
            // Only perform Hero and Scale transitions if motion is normal
            return ScaleTransition(
              scale: _scaleAnimation,
              child: Hero(
                tag: 'start_sleep_fab',
                flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                  return ScaleTransition(scale: animation, child: toHeroContext.widget);
                },
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFabBody(NeoThemeExtension theme) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.border, width: 3),
        boxShadow: [theme.defaultShadow],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(child: Icon(widget.icon, color: Colors.white)),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
