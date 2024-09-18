class Salary {
  final double salary; // Corresponds to account_id
  final DateTime resetDatePlanning; // Corresponds to create_date

  Salary({
    required this.salary,
    required this.resetDatePlanning,
  });

  // Convert a Map (JSON) into an Account object.
  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      salary: (json['salary'] as num).toDouble(),
      resetDatePlanning: DateTime.parse(json['resetDatePlanning']),
    );
  }
}
