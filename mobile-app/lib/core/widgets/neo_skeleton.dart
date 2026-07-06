import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';

class NeoSkeletonCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const NeoSkeletonCard({Key? key, this.width, this.height, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.border, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class NeoSkeletonCircle extends StatelessWidget {
  final double size;

  const NeoSkeletonCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.textSecondary.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: theme.border, width: 2),
      ),
    );
  }
}

class NeoSkeletonText extends StatelessWidget {
  final double width;
  final double height;

  const NeoSkeletonText({Key? key, required this.width, this.height = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.textSecondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class NeoLoadingOverlay extends StatelessWidget {
  final String message;

  const NeoLoadingOverlay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    return Container(
      color: theme.background.withOpacity(0.8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.surface,
            border: Border.all(color: theme.border, width: 3),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [theme.defaultShadow],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                strokeWidth: 4,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
