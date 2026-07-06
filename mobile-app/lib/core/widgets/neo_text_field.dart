import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';

class NeoTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const NeoTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(color: theme.textPrimary, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: theme.textSecondary.withOpacity(0.5)),
        filled: true,
        fillColor: theme.surface,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: theme.defaultBorderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: theme.defaultBorderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(
            color: theme.primary,
            width: theme.defaultBorderSide.width + 1, // Slightly thicker on focus
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(
            color: Colors.red,
            width: theme.defaultBorderSide.width,
          ),
        ),
      ),
    );
  }
}
