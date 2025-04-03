import 'package:intl/intl.dart';

class UtilsDateTime {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEE dd MMMM yyyy');
    return formatter.format(date);
  }

  static String monthYearFormat(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(DateTime(date.year, date.month));
  }

  static String yearMonthFormat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM');
    return formatter.format(date);
  }
}
