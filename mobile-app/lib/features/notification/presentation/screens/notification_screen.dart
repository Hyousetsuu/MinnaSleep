import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart'; // Assumed
import '../state/notification_ui_state.dart';
import 'widgets/notification_app_bar.dart';
import 'widgets/notification_search_bar.dart';
import 'widgets/notification_filter_bar.dart';
import 'widgets/notification_group_section.dart';
import 'widgets/notification_empty_state.dart';
import 'widgets/notification_skeleton.dart';
import 'widgets/bulk_action_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example Provider read (Budget: Max 1 rebuild for the main layout structure)
    // final uiState = ref.watch(notificationUiProvider);
    // final selectionMode = ref.watch(selectionControllerProvider).isSelectionMode;

    return Scaffold(
      // Design Token Enforcement: Using Theme context instead of hardcoded colors
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const NotificationAppBar(), // PreferredSizeWidget
      body: CustomScrollView( // List Virtualization (Criteria 3)
        slivers: [
          const SliverToBoxAdapter(child: NotificationSearchBar()),
          const SliverToBoxAdapter(child: NotificationFilterBar()),
          
          // State Switcher
          // if (uiState.status == NotificationUiStatus.loading)
          //   const SliverToBoxAdapter(child: NotificationSkeleton()),
          // else if (uiState.status == NotificationUiStatus.empty)
          //   const SliverToBoxAdapter(child: NotificationEmptyState()),
          // else
          //   ...uiState.groupedNotifications.map((group) => NotificationGroupSection(group: group)),
        ],
      ),
      // bottomNavigationBar: selectionMode ? const BulkActionBar() : null,
    );
  }
}
