import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_card.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class HistoryCalendar extends StatelessWidget {
  final DateTime focusedMonth;
  final Function(DateTime) onMonthChanged;

  const HistoryCalendar({
    Key? key,
    required this.focusedMonth,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final monthFormat = DateFormat('MMMM yyyy');

    return NeoCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(LucideIcons.chevronLeft, color: theme.textPrimary),
                onPressed: () {
                  onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month - 1));
                },
              ),
              Text(
                monthFormat.format(focusedMonth),
                style: AppTypography.heading2.copyWith(color: theme.textPrimary),
              ),
              IconButton(
                icon: Icon(LucideIcons.chevronRight, color: theme.textPrimary),
                onPressed: () {
                  onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month + 1));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Days Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return Text(
                day,
                style: TextStyle(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          // Mock Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 31, // Mock 31 days
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final day = index + 1;
              final hasData = day % 3 != 0; // Mock some missing data
              return Container(
                decoration: BoxDecoration(
                  color: hasData ? theme.primary : theme.background,
                  border: Border.all(color: theme.border, width: 1.5),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    color: hasData ? Colors.white : theme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
