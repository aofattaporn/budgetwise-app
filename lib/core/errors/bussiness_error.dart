class BussinessError implements Exception {
  final String head;
  final String desc;
  final DateTime timestamp;

  BussinessError(
      {required this.head, required this.desc, required this.timestamp});

  @override
  String toString() => 'BussinessError: $desc';
}
