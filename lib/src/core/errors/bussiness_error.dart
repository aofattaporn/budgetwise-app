class BussinessError implements Exception {
  final String message;
  final String desc;
  final DateTime timestamp;

  BussinessError(
      {required this.message, required this.desc, required this.timestamp});

  @override
  String toString() => 'BussinessError: $message';
}
