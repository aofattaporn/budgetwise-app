import 'package:json_annotation/json_annotation.dart';

part 'plan_item_entity.g.dart';

@JsonSerializable()
class PlanItemEntity {
  @JsonKey(name: 'plan_id')
  final int planId;

  @JsonKey(name: 'title')
  final DateTime title;

  @JsonKey(name: 'usage')
  final double usage;

  @JsonKey(name: 'plan_amount')
  final double planAmount;

  @JsonKey(name: 'category')
  final String category;

  PlanItemEntity({
    required this.planId,
    required this.title,
    required this.usage,
    required this.planAmount,
    required this.category,
  });

  factory PlanItemEntity.fromJson(Map<String, dynamic> json) =>
      _$PlanItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlanItemEntityToJson(this);
}
