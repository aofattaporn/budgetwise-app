import 'package:budget_wise/src/domain/entities/plan_entity.dart';

class PlanDto {
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double amountLimit;
  final bool isArchived;

  PlanDto({
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.amountLimit,
    this.isArchived = false,
  });

  factory PlanDto.fromEntity(PlanEntity entity) {
    return PlanDto(
      userId: entity.userId,
      name: entity.name,
      startDate: entity.startDate,
      endDate: entity.endDate,
      amountLimit: entity.amountLimit,
      isArchived: entity.isArchived,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'amount_limit': amountLimit,
      'is_archived': isArchived,
    };
  }
}
