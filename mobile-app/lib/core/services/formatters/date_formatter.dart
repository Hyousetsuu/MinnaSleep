import 'package:intl/intl.dart';

/// Centralized service for Date and Time formatting.
/// Adheres to ReadModel philosophy where UI only consumes strings.
class DateFormatter {
  /// Returns a relative time string (e.g. "Just now", "5m ago", "2h ago")
  static String formatRelativeTime(DateTime dateTime, {String locale = 'en'}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return locale == 'id' ? 'Baru saja' : 'Just now';
    } else if (difference.inMinutes < 60) {
      return locale == 'id' ? '${difference.inMinutes}m yang lalu' : '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return locale == 'id' ? '${difference.inHours}j yang lalu' : '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return locale == 'id' ? '${difference.inDays}h yang lalu' : '${difference.inDays}d ago';
    }

    return DateFormat.yMMMd(locale).format(dateTime);
  }

  /// Formats date to a standard readable form, e.g. "Jul 7, 2026"
  static String formatDate(DateTime dateTime, {String locale = 'en'}) {
    return DateFormat.yMMMd(locale).format(dateTime);
  }

  /// Formats a time string, e.g. "07:30 AM"
  static String formatTime(DateTime dateTime, {String locale = 'en'}) {
    return DateFormat.jm(locale).format(dateTime);
  }

  /// Formats duration (e.g. 7h 30m)
  static String formatDuration(Duration duration, {String locale = 'en'}) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (locale == 'id') {
      if (hours > 0) return '${hours}j ${minutes}m';
      return '${minutes}m';
    } else {
      if (hours > 0) return '${hours}h ${minutes}m';
      return '${minutes}m';
    }
  }
}
