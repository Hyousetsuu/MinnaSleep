import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_text_field.dart';
import 'widgets/history_calendar.dart';
import 'widgets/history_daily_list.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedMonth = DateTime.now();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleDelete(String id) {
    // Soft delete logic (update Drift DB status = 'deleted')
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Session deleted.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Restore logic
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'HISTORY',
                style: TextStyle(
                  color: theme.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 24),
              
              // Search & Filter
              Row(
                children: [
                  Expanded(
                    child: NeoTextField(
                      controller: _searchController,
                      hintText: 'Search notes or dates...',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      border: Border.all(color: theme.border, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [theme.defaultShadow],
                    ),
                    child: Icon(LucideIcons.filter, color: theme.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Calendar View
              HistoryCalendar(
                focusedMonth: _focusedMonth,
                onMonthChanged: (newMonth) {
                  setState(() => _focusedMonth = newMonth);
                },
              ),
              const SizedBox(height: 32),
              
              // Daily List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT SESSIONS',
                    style: TextStyle(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Icon(LucideIcons.list, color: theme.textSecondary),
                ],
              ),
              const SizedBox(height: 16),
              
              HistoryDailyList(
                sessions: const [1, 2, 3, 4, 5], // Mock data array
                onDelete: _handleDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
