import 'package:intl/intl.dart';

String formatOrderDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '--';

  try {
    // Parse the input string into a DateTime
    final DateTime date = DateTime.parse(dateString);
    final DateTime now = DateTime.now();

    // Normalize both to remove time differences
    final today = DateTime(now.year, now.month, now.day);
    final orderDate = DateTime(date.year, date.month, date.day);

    final tomorrow = today.add(const Duration(days: 1));

    if (orderDate == today) {
      return 'Today';
    } else if (orderDate == tomorrow) {
      return 'Tomorrow';
    } else {
      return DateFormat('dd-MM-yyyy').format(orderDate);
    }
  } catch (e) {
    // If the date format is unexpected, show raw value
    print('⚠️ Date parsing error: $e');
    return dateString;
  }
}
