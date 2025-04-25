class CommonError implements Exception {
  final String message;
  CommonError(this.message);

  @override
  String toString() => 'PlanException: $message';
}
