import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';
import '../theme/app_animations.dart';

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

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        transform: Matrix4.translationValues(
          _isPressed ? 4.0 : 0.0,
          _isPressed ? 4.0 : 0.0,
          0.0,
        ),
        width: widget.isFullWidth ? double.infinity : null,
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
      ),
    );
  }
}
