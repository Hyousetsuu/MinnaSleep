import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_state.dart';
import 'route_paths.dart';

class RouteGuard {
  static String? guard(AuthState authState, String currentPath) {
    final isGoingToGuestRoute = _isGuestRoute(currentPath);
    final isGoingToSplash = currentPath == RoutePaths.splash;

    if (authState is AuthStateLoading || authState is AuthStateInitial) {
      // While loading, let them be on splash or redirect to splash if not
      return isGoingToSplash ? null : RoutePaths.splash;
    }

    if (authState is AuthStateUnauthenticated) {
      // If unauthenticated, allow them on guest routes, else redirect to onboarding/login
      if (isGoingToGuestRoute || isGoingToSplash) return null;
      return RoutePaths.onboarding;
    }

    if (authState is AuthStateAuthenticated) {
      // If authenticated but trying to go to guest route, redirect to dashboard
      if (isGoingToGuestRoute || isGoingToSplash) {
        return RoutePaths.dashboard;
      }
      return null; // Let them proceed to any protected route
    }

    if (authState is AuthStateProfileIncomplete) {
      // Must complete profile
      if (currentPath == RoutePaths.profileSetup) return null;
      return RoutePaths.profileSetup;
    }

    return null;
  }

  static bool _isGuestRoute(String path) {
    return path == RoutePaths.login ||
           path == RoutePaths.register ||
           path == RoutePaths.onboarding ||
           path == RoutePaths.forgotPassword;
  }
}
