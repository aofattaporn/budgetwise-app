class PlanItemSummary {
  final String id;
  final String planId;
  final String name;
  final double amountLimit;
  final String type;
  final String? iconName;
  final DateTime createdAt;
  final DateTime updatedAt;

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
}
