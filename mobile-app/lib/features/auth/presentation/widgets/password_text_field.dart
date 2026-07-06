import 'package:flutter/material.dart';
import '../../../../core/widgets/neo_text_field.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const PasswordTextField({
    Key? key,
    this.hintText = 'Password',
    this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return NeoTextField(
      hintText: widget.hintText,
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      // For some reason neo_text_field doesn't have onChanged yet, we should add it if we need to update state,
      // but for now we can just rely on the controller.
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? LucideIcons.eye : LucideIcons.eyeOff,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
