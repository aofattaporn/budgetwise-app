class PlanItemEntity {
  final int planId;
  final DateTime title;
  final double usage;
  final double planAmount;
  final String category;

  PlanItemEntity({
    required this.planId,
    required this.title,
    required this.usage,
    required this.planAmount,
    required this.category,
  });

  factory PlanItemEntity.fromJson(Map<String, dynamic> json) {
    return PlanItemEntity(
      planId: json['plan_id'] as int,
      title: DateTime.parse(json['title'] as String),
      usage: (json['usage'] as num).toDouble(),
      planAmount: (json['plan_amount'] as num).toDouble(),
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_id': planId,
      'title': title.toIso8601String(),
      'usage': usage,
      'plan_amount': planAmount,
      'category': category,
    };
  }
}
