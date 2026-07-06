import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme_extension.dart';
import '../../core/widgets/neo_bottom_nav.dart';
import '../../core/widgets/neo_animated_fab.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Screens
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const HistoryScreen(),
    const AnalyticsScreen(),
    const Center(child: Text('Community UI Placeholder')), // Community
    const Center(child: Text('Profile UI Placeholder')), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: NeoAnimatedFAB(
        label: 'START SLEEP',
        icon: LucideIcons.moon,
        onPressed: () {
          context.push('/active-sleep');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NeoBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
