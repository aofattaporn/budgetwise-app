// ignore: file_names
class UserFin {
  final double salary;
  final DateTime month;
  final double usages;

  UserFin({
    required this.salary,
    required this.month,
    required this.usages,
  });

  // Convert a Map (JSON) into an Account object.
  factory UserFin.fromJson(Map<String, dynamic> json) {
    return UserFin(
      salary: (json['salary'] as num).toDouble(),
      month: DateTime.parse(json['month']),
      usages: (json['usages'] as num).toDouble(),
    );
  }
}
