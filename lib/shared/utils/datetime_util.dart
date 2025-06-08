import 'package:intl/intl.dart';

class UtilsDateTime {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEE dd MMMM yyyy');
    return formatter.format(date);
  }

  static String dayMonthYearFormat(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  static String monthYearFormat(DateTime date) {
    final DateFormat formatter = DateFormat('MMM yyyy');
    return formatter.format(date);
  }

  static String dateTimeReadableFormat(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm');
    return formatter.format(date);
  }

  static String dateTimeSecondFormat(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm:ss');
    return formatter.format(date);
  }

  static String yearMonthFormat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM');
    return formatter.format(date);
  }
}
