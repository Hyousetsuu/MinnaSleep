import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';
import '../theme/app_animations.dart';
import '../theme/motion_policy.dart';

class NeoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isFullWidth;

  const NeoButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isFullWidth = true,
  }) : super(key: key);

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final bgColor = widget.backgroundColor ?? theme.primary;
    final txtColor = widget.textColor ?? theme.textPrimary;
    final motionPolicy = MotionPolicy(context);

    return Semantics(
      button: true,
      label: widget.text,
      hint: "Double tap to activate",
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: motionPolicy.buildTransition(
          child: _buildButtonBody(bgColor, txtColor, theme),
          normalBuilder: (context, child) {
            // Apply scale/translate animation for normal motion
            return AnimatedContainer(
              duration: AppAnimations.fast,
              transform: Matrix4.translationValues(
                _isPressed ? 4.0 : 0.0,
                _isPressed ? 4.0 : 0.0,
                0.0,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonBody(Color bgColor, Color txtColor, NeoThemeExtension theme) {
    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.fromBorderSide(theme.defaultBorderSide),
        borderRadius: AppRadius.borderMd,
        boxShadow: _isPressed ? [] : [theme.defaultShadow],
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: txtColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
