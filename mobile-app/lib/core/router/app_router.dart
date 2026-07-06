import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_state.dart';
import 'route_paths.dart';
import 'route_names.dart';
import 'route_guard.dart';
import '../theme/app_animations.dart';

// Import Actual Screens
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verify_email_screen.dart';
import '../../features/auth/presentation/screens/profile_setup_screen.dart';
import '../layout/main_layout.dart';
import '../../features/sleep_tracking/presentation/screens/active_sleep_screen.dart';

// Placeholder for dashboard
import 'package:flutter/material.dart';
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);
  @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text(title)));
}

final appRouterProvider = Provider<GoRouter>((ref) {
  // In a real app, listen to authState changes
  // final authState = ref.watch(authStateProvider);
  const authState = AuthState.unauthenticated(); // Dummy for now

  return GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: (context, state) {
      return RouteGuard.guard(authState, state.uri.path);
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-email', // Note: missing in route_paths initially, added here for completeness
        name: 'verifyEmail',
        builder: (context, state) => const VerifyEmailScreen(email: 'user@example.com'),
      ),
      GoRoute(
        path: RoutePaths.profileSetup,
        name: RouteNames.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: RouteNames.dashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const MainLayout(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: AppAnimations.normal,
        ),
      ),
      GoRoute(
        path: '/active-sleep',
        name: 'activeSleep',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ActiveSleepScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(scale: animation, child: child);
          },
          transitionDuration: AppAnimations.hero,
        ),
      ),
      // ... more routes
    ],
  );
});
