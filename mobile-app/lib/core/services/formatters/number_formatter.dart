import 'package:intl/intl.dart';

/// Centralized service for Number and Currency formatting.
class NumberFormatter {
  /// Formats integer into a compact form (e.g., 1.5K, 2M)
  static String formatCompact(int number, {String locale = 'en'}) {
    final formatter = NumberFormat.compact(locale: locale);
    return formatter.format(number);
  }

  /// Formats with standard grouping separator (e.g. 1,000)
  static String formatWithGrouping(int number, {String locale = 'en'}) {
    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(number);
  }
}
