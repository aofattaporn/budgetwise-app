// ignore: file_names
class UserBudgetInfoEntity {
  final double salary;
  final DateTime month;
  final double usages;

  UserBudgetInfoEntity({
    required this.salary,
    required this.month,
    required this.usages,
  });

  UserBudgetInfoEntity.createSalary({
    required this.salary,
    required this.month,
  }) : usages = 0;

  // Convert a Map (JSON) into an Account object.
  factory UserBudgetInfoEntity.fromJson(Map<String, dynamic> json) {
    return UserBudgetInfoEntity(
      salary: (json['salary'] as num).toDouble(),
      month: DateTime.parse(json['month']),
      usages: (json['usages'] as num).toDouble(),
    );
  }

  // Convert an Account object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'salary': salary,
      'month': month.toIso8601String(),
      'usages': usages,
    };
  }

  Map<String, dynamic> toNewJsonSalary() {
    return {
      'salary': salary,
      'month': DateTime.utc(month.year, month.month).toIso8601String(),
    };
  }
}
