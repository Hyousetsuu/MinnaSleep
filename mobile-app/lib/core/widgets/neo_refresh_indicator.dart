import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_animations.dart';

class NeoRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const NeoRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<NeoRefreshIndicator> createState() => _NeoRefreshIndicatorState();
}

class _NeoRefreshIndicatorState extends State<NeoRefreshIndicator> {
  // Simulating the custom states requested by user
  // For a production ready custom refresh indicator, we would use custom scroll physics
  // or a library like pull_to_refresh. For now, we wrap the native one but simulate the UI.

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return RefreshIndicator(
      color: theme.primary,
      backgroundColor: theme.surface,
      strokeWidth: 3,
      onRefresh: () async {
        try {
          await widget.onRefresh();
          // Simulate showing success briefly
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(LucideIcons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Your sleep data is up to date.", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                backgroundColor: theme.success,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: theme.border, width: 2),
                ),
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(LucideIcons.alertTriangle, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Couldn't refresh. Showing cached data.", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                backgroundColor: theme.warning,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: theme.border, width: 2),
                ),
              ),
            );
          }
        }
      },
      child: widget.child,
    );
  }
}
