import 'package:intl/intl.dart';

class UtilsDateTime {
  static String formatDate(DateTime date) {
    // Define the format
    final DateFormat formatter = DateFormat('EEE dd MMMM yyyy');

    // Format the DateTime object
    return formatter.format(date);
  }
}
