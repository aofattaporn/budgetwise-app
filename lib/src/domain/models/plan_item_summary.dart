class PlanItemSummary {
  final String id;
  final String name;
  final double amountLimit;
  final String type;
  final String? iconName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String planId;
  final double summaryUsage;

  PlanItemSummary({
    required this.id,
    required this.planId,
    required this.name,
    required this.amountLimit,
    required this.type,
    required this.iconName,
    required this.createdAt,
    required this.updatedAt,
    required this.summaryUsage,
  });

  factory PlanItemSummary.fromJson(Map<String, dynamic> json) {
    return PlanItemSummary(
      id: json['id'],
      planId: json['plan_id'],
      name: json['name'],
      amountLimit: (json['amount_limit'] as num).toDouble(),
      type: json['type'],
      iconName: json['icon_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      summaryUsage: (json['summary_usage'] as num).toDouble(),
    );
  }
}
