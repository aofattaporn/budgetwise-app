import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

class PlanItemDto {
  final int planId;
  final String title;
  final double planAmount;
  final String category;
  final String iconName;

  PlanItemDto(
      {required this.planId,
      required this.title,
      required this.planAmount,
      required this.category,
      required this.iconName});

  factory PlanItemDto.fromEntity(PlanItemEntity entity) {
    return PlanItemDto(
      planId: entity.planId,
      title: entity.title,
      planAmount: entity.planAmount,
      category: entity.category,
      iconName: entity.iconName,
    );
  }
}
