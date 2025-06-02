class PlanEntity {
  final String id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double amountLimit;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.amountLimit,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanEntity.fromJson(Map<String, dynamic> json) => PlanEntity(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        amountLimit: (json['amount_limit'] as num).toDouble(),
        isArchived: json['is_archived'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'amount_limit': amountLimit,
        'is_archived': isArchived,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
