import 'package:budget_wise/src/domain/entities/plan_entity.dart';

class PlanDto {
  final String? id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double amountLimit;
  final bool isArchived;
  final String? createdAt;
  final String? updatedAt;

  PlanDto({
    this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.amountLimit,
    required this.isArchived,
    this.createdAt,
    this.updatedAt,
  });

  factory PlanDto.fromJson(Map<String, dynamic> json) {
    return PlanDto(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      amountLimit: (json['amount_limit'] as num).toDouble(),
      isArchived: json['is_archived'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
        'amount_limit': amountLimit,
        'is_archived': isArchived,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// Converts to domain entity
  Map<String, dynamic> toInsertJson() => {
        'user_id': userId,
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
        'amount_limit': amountLimit,
        'is_archived': isArchived,
      };

  /// Converts to domain entity
  PlanEntity toEntity() {
    return PlanEntity(
      id: id!,
      userId: userId,
      name: name,
      startDate: startDate,
      endDate: endDate,
      amountLimit: amountLimit,
      isArchived: isArchived,
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
    );
  }

  /// Converts from domain entity
  static PlanDto fromEntity(PlanEntity entity) {
    return PlanDto(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      startDate: entity.startDate,
      endDate: entity.endDate,
      amountLimit: entity.amountLimit,
      isArchived: entity.isArchived,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }
}
