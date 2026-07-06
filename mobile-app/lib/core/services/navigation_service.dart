import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static void go(String location) {
    if (context != null) {
      GoRouter.of(context!).go(location);
    }
  }

  static void push(String location) {
    if (context != null) {
      GoRouter.of(context!).push(location);
    }
  }

  static void pop() {
    if (context != null) {
      if (GoRouter.of(context!).canPop()) {
        GoRouter.of(context!).pop();
      }
    }
  }

  static void popUntil(String location) {
    // Requires custom implementation depending on router setup, typically popping until match.
  }
}
