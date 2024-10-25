class Numbers {
  static double calPercentage(double current, double limit) {
    // Avoid division by zero
    if (limit == 0) return 0;

    // Calculate percentage with floating-point precision
    double percentage = (current / limit) * 100;

    // Return percentage rounded to two decimal places
    return double.parse(percentage.toStringAsFixed(2));
  }
}
