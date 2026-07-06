import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import 'widgets/weekly_chart.dart';
import 'widgets/daily_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'ANALYTICS',
                style: TextStyle(
                  color: theme.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border.all(color: theme.border, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: theme.primary,
                    border: Border.all(color: theme.border, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: theme.textSecondary,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'D'),
                    Tab(text: 'W'),
                    Tab(text: 'M'),
                    Tab(text: 'Y'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMockView('Daily View'),
                  _buildWeeklyView(),
                  _buildMockView('Monthly View'),
                  _buildMockView('Yearly View'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        children: const [
          WeeklyChart(),
          SizedBox(height: 24),
          DailyChart(),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMockView(String title) {
    return Center(
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
