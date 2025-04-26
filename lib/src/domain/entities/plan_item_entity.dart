class PlanItemEntity {
  final int id;
  final int planId;
  final String title;
  final double usage;
  final double planAmount;
  final String category;
  final DateTime createdAt;

  PlanItemEntity({
    required this.id,
    required this.planId,
    required this.title,
    required this.usage,
    required this.planAmount,
    required this.category,
    required this.createdAt,
  });

  factory PlanItemEntity.fromJson(Map<String, dynamic> json) {
    return PlanItemEntity(
      id: json['id'] as int,
      planId: json['plan_id'] as int,
      title: json['title'] as String,
      usage: (json['usage'] as num).toDouble(),
      planAmount: (json['plan_amount'] as num).toDouble(),
      category: json['category'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'title': title,
      'usage': usage,
      'plan_amount': planAmount,
      'category': category,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
