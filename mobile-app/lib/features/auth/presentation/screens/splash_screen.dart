import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_skeleton.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _fadeController.forward().then((_) {
      // Trigger initialization after fade in
      ref.read(authProvider.notifier).checkSession();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    // Note: routing is handled automatically by GoRouter's redirect based on authState changes

    return Scaffold(
      backgroundColor: theme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MINNA',
                style: AppTypography.display.copyWith(
                  color: theme.textPrimary,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                'SLEEP',
                style: AppTypography.display.copyWith(
                  color: theme.primary,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 48),
              // Neo Brutalism style Loading Skeleton
              const LoadingSkeleton(
                width: 200,
                height: 20,
              ),
              const SizedBox(height: 16),
              const LoadingSkeleton(
                width: 150,
                height: 20,
              ),
              const SizedBox(height: 64),
              Text(
                'v1.0.0',
                style: AppTypography.caption.copyWith(
                  color: theme.textSecondary,
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
