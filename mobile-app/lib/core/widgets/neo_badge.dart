import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';

class NeoBadge extends StatelessWidget {
  final String text;
  final Color? color;
  
  const NeoBadge({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color ?? theme.secondary,
        border: Border.fromBorderSide(theme.defaultBorderSide),
        borderRadius: AppRadius.borderRound,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
