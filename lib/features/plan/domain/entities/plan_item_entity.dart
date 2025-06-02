class PlanItemEntity {
  final String id;
  final String planId;
  final String name;
  final double amountLimit;
  final String type;
  final String? iconName; // <- เพิ่มตรงนี้
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanItemEntity({
    required this.id,
    required this.planId,
    required this.name,
    required this.amountLimit,
    required this.type,
    this.iconName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanItemEntity.fromJson(Map<String, dynamic> json) {
    return PlanItemEntity(
      id: json['id'],
      planId: json['plan_id'],
      name: json['name'],
      amountLimit: (json['amount_limit'] as num).toDouble(),
      type: json['type'],
      iconName: json['icon_name'], // <- รองรับ null
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'name': name,
      'amount_limit': amountLimit,
      'type': type,
      'icon_name': iconName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
