class NotfoundError implements Exception {
  final String head;
  final String desc;
  final DateTime timestamp;

  NotfoundError(
      {required this.head, required this.desc, required this.timestamp});
}
