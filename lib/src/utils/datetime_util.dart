import 'package:intl/intl.dart';

class UtilsDateTime {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEE dd MMMM yyyy');
    return formatter.format(date);
  }

  static String monthYearFormat(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(DateTime(date.year, date.month));
  }
}
