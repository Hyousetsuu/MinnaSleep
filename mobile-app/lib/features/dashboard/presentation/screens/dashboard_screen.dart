import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/dashboard_providers.dart';

import 'widgets/greeting_header.dart';
import 'widgets/sleep_score_card.dart';
import 'widgets/today_sleep_card.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/weekly_progress_card.dart';
import 'widgets/ai_insight_card.dart';
import 'widgets/sleep_timeline_card.dart';
import 'widgets/challenge_banner.dart';
import 'widgets/recent_sleep_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: dashboardState.when(
          data: (data) {
            return RefreshIndicator(
              color: theme.primary,
              backgroundColor: theme.surface,
              onRefresh: () => ref.refresh(dashboardProvider.future),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 32.0),
                children: [
                  GreetingHeader(
                    user: data.overview,
                    onNotificationTap: () {},
                  ),
                  SleepScoreCard(stats: data.statistics),
                  TodaySleepCard(stats: data.statistics),
                  QuickActionCard(
                    onStartSleep: () => context.push('/active-sleep'),
                    onManualEntry: () {},
                  ),
                  const ChallengeBanner(),
                  WeeklyProgressCard(weeklyData: data.weeklyProgress),
                  AIInsightCard(insight: data.insight),
                  SleepTimelineCard(events: data.timeline),
                  
                  // Recent Activity Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RECENT ACTIVITY',
                          style: TextStyle(
                            color: theme.textPrimary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...data.recentActivities.map((activity) {
                          return RecentSleepCard(
                            activity: activity,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => _buildSkeletonLoader(context, theme),
          error: (error, stack) => ErrorState(
            message: 'Unable to load dashboard.\n$error',
            onRetry: () => ref.refresh(dashboardProvider),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader(BuildContext context, NeoThemeExtension theme) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      children: [
        Row(
          children: [
            const LoadingSkeleton(width: 56, height: 56, borderRadius: BorderRadius.all(Radius.circular(28))),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoadingSkeleton(width: 100, height: 16),
                SizedBox(height: 8),
                LoadingSkeleton(width: 150, height: 24),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        const LoadingSkeleton(width: double.infinity, height: 300),
        const SizedBox(height: 16),
        const LoadingSkeleton(width: double.infinity, height: 120),
        const SizedBox(height: 16),
        const LoadingSkeleton(width: double.infinity, height: 180),
      ],
    );
  }
}
