class PlanItemInsertDto {
  final String planId;
  final String name;
  final double amountLimit;
  final String type;
  final String? iconName;

  PlanItemInsertDto({
    required this.planId,
    required this.name,
    required this.amountLimit,
    required this.type,
    this.iconName,
  });

  Map<String, dynamic> toJson() {
    return {
      'plan_id': planId,
      'name': name,
      'amount_limit': amountLimit,
      'type': type,
      'icon_name': iconName,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
