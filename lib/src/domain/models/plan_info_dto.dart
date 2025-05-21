import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

class PlanInfoDto {
  final String id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double amountLimit;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PlanItemEntity> planItems;

  PlanInfoDto({
    required this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.amountLimit,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.planItems,
  });

  factory PlanInfoDto.fromJson(Map<String, dynamic> json) => PlanInfoDto(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        amountLimit: (json['amount_limit'] as num).toDouble(),
        isArchived: json['is_archived'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        planItems: (json['plan_items'] as List)
            .map((e) => PlanItemEntity.fromJson(e))
            .toList(),
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
        'plan_items': planItems.map((item) => item.toJson()).toList(),
      };

  PlanEntity toEntity() => PlanEntity(
        id: id,
        userId: userId,
        name: name,
        startDate: startDate,
        endDate: endDate,
        amountLimit: amountLimit,
        isArchived: isArchived,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
