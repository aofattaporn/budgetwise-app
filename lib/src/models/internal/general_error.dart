// ignore: file_names
class GeneralError {
  final int code;
  final String timestamp;
  final String errorMessage;

  @override
  String toString() => 'GeneralError: $errorMessage';

  GeneralError({
    required this.code,
    required this.timestamp,
    required this.errorMessage,
  });

  // Convert a Map (JSON) into a GeneralError object.
  factory GeneralError.fromJson(Map<String, dynamic> json) {
    return GeneralError(
      code: json['code'] as int,
      timestamp: json['timestamp'] as String,
      errorMessage: json['errorMessage'] as String,
    );
  }

  // Convert a GeneralError object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'timestamp': timestamp,
      'errorMessage': errorMessage,
    };
  }
}
