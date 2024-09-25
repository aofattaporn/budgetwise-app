class UserInfo {
  final double salary;
  final DateTime resetDatePlanning;
  final double currentUsageMonthly;

  UserInfo({
    required this.salary,
    required this.resetDatePlanning,
    required this.currentUsageMonthly,
  });

  // Convert a Map (JSON) into an Account object.
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      salary: (json['salary'] as num).toDouble(),
      resetDatePlanning: DateTime.parse(json['resetDatePlanning']),
      currentUsageMonthly: (json['currentUsageMonthly'] as num).toDouble(),
    );
  }
}
