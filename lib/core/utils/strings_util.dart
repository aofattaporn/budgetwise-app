import 'package:intl/intl.dart';

class StringUtil {
  // General method to normalize number from any string input
  static String normalizeNumber(String rawNumber) {
    String cleanedValue = rawNumber.replaceAll(RegExp(r'[^\d.]'), '');

    if (cleanedValue.isEmpty || cleanedValue == '.') return '';
    List<String> parts = cleanedValue.split('.');
    final NumberFormat formatter = NumberFormat('#,###');
    String formattedIntegerPart = formatter.format(int.parse(parts[0]));
    if (parts.length > 1) {
      String decimalPart = parts[1];
      return '$formattedIntegerPart.$decimalPart';
    }

    return formattedIntegerPart;
  }

  // General method reject '/'
  static String replacePath(String path) {
    return path.replaceAll('/', '');
  }
}
