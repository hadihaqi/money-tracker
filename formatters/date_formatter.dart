import 'package:intl/intl.dart';

String formatRelativeDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final input = DateTime(date.year, date.month, date.day);

  final difference = today.difference(input).inDays;

  // Today
  if (difference == 0) return "Today";

  // Yesterday
  if (difference == 1) return "Yesterday";

  // Within last 7 days (1-6 days ago)
  if (difference < 7) return "$difference days ago";

  // Last week (7–13 days ago)
  if (difference < 14) return "Last week";

  // If within this month but > 2 weeks ago
  if (date.year == now.year && date.month == now.month) {
    return "${(difference / 7).floor()} weeks ago";
  }

  // Last month
  final lastMonth = DateTime(now.year, now.month - 1);
  if (date.year == lastMonth.year && date.month == lastMonth.month) {
    return "Last month";
  }

  // Months difference
  int monthsAgo = (now.year - date.year) * 12 + (now.month - date.month);

  if (monthsAgo < 12) {
    if (monthsAgo == 1) return "1 month ago";
    return "$monthsAgo months ago";
  }

  // Years difference
  int yearsAgo = now.year - date.year;

  if (yearsAgo == 1) return "Last year";
  if (yearsAgo > 1) return "$yearsAgo years ago";

  // Fallback: formatted date
  return DateFormat('MMM dd, yyyy').format(date);
}
