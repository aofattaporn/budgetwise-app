import 'package:intl/intl.dart';

class Numbers {
  static double calPercentage(double current, double limit) {
    if (limit == 0) return 0;

    double percentage = (current / limit) * 100;
    return double.parse(percentage.toStringAsFixed(2));
  }

  static String formatAmount(double amount) {
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(amount);
  }
}
