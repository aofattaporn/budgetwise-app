class TechnicalError implements Exception {
  final String message;
  final DateTime timestamp;
  TechnicalError({required this.message, required this.timestamp});

  @override
  String toString() => 'TechnicalError: $message';
}
