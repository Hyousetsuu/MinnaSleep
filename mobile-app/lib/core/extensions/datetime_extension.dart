import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  String toFormattedDate() {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String toFormattedTime() {
    return DateFormat('h:mm a').format(this);
  }

  String toIso8601StringWithTimezone() {
    return toIso8601String(); // Simplified for now, backend expects ISO8601
  }
}
