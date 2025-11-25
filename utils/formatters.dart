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

String formatNumberForDisplay(num number) {
  final NumberFormat formatter;

  // 1. Check if the number is mathematically a whole number.
  //    We use number.roundToDouble() for double comparison or check if it's an int.
  if (number is int || number == number.roundToDouble()) {
    // 2. If it's a whole number (e.g., 12345.0):
    //    Use a pattern that includes thousands separators (,) but NO decimal places.
    //    '###,##0' is a standard pattern for integers with separators.
    formatter = NumberFormat('###,##0');
  } else {
    // 3. If it has a fractional part (e.g., 12345.67):
    //    Use a pattern that includes thousands separators (,) AND one decimal place.
    //    '###,##0.0' is used to enforce exactly one decimal place.
    formatter = NumberFormat('###,##0.0');
  }

  return formatter.format(number);
}
