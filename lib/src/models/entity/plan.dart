class Plan {
  int id;
  DateTime startDate;
  DateTime endDate;
  double totalBudget;
  DateTime createAt;

  Plan({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
    required this.createAt,
  });

  // Factory constructor to create a Plan object from a Map
  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] as int,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: DateTime.parse(map['end_date'] as String),
      totalBudget: (map['total_budget'] as num).toDouble(),
      createAt: DateTime.parse(map['create_at'] as String),
    );
  }

  // Method to convert a Plan object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_budget': totalBudget,
      'create_at': createAt.toIso8601String(),
    };
  }
}
