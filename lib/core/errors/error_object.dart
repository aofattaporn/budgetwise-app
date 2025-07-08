class ErrorObject {
  final bool isError;
  final String? message;
  final String? desc;
  final DateTime? timestamp;

  ErrorObject({
    required this.isError,
    this.message,
    this.desc,
    this.timestamp,
  });
}
