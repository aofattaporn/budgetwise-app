import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

class PlanItemDto {
  final String id;
  final String planId;
  final String name;
  final double amountLimit;
  final String type;
  final String? iconName;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanItemDto({
    required this.id,
    required this.planId,
    required this.name,
    required this.amountLimit,
    required this.type,
    this.iconName,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert from JSON
  factory PlanItemDto.fromJson(Map<String, dynamic> json) {
    return PlanItemDto(
      id: json['id'],
      planId: json['plan_id'],
      name: json['name'],
      amountLimit: (json['amount_limit'] as num).toDouble(),
      type: json['type'],
      iconName: json['icon_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert from Entity
  factory PlanItemDto.fromEntity(PlanItemEntity entity) {
    return PlanItemDto(
      id: entity.id,
      planId: entity.planId,
      name: entity.name,
      amountLimit: entity.amountLimit,
      type: entity.type,
      iconName: entity.iconName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to Entity
  PlanItemEntity toEntity() {
    return PlanItemEntity(
      id: id,
      planId: planId,
      name: name,
      amountLimit: amountLimit,
      type: type,
      iconName: iconName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Convert to JSON for inserting into Supabase
  Map<String, dynamic> toInsertJson() {
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
