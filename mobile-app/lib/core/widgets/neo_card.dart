import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_radius.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const NeoCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.surface,
        border: Border.fromBorderSide(theme.defaultBorderSide),
        borderRadius: AppRadius.borderLg,
        boxShadow: [theme.defaultShadow],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
