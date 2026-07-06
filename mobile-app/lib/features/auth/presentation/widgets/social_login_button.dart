import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_animations.dart';

class SocialLoginButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialLoginButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final bgColor = widget.backgroundColor ?? theme.surface;
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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.fromBorderSide(theme.defaultBorderSide),
          borderRadius: AppRadius.borderMd,
          boxShadow: _isPressed ? [] : [theme.defaultShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            const SizedBox(width: 12),
            Text(
              widget.text,
              style: TextStyle(
                color: txtColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
