import 'package:json_annotation/json_annotation.dart';

part 'plan_entity.g.dart';

@JsonSerializable()
class PlanEntity {
  final int id;

  @JsonKey(name: 'start_date')
  final DateTime startDate;

  @JsonKey(name: 'end_date')
  final DateTime endDate;

  @JsonKey(name: 'total_budget')
  final double totalBudget;

  @JsonKey(name: 'create_at')
  final DateTime createAt;

  PlanEntity({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
    required this.createAt,
  });

  factory PlanEntity.fromJson(Map<String, dynamic> json) =>
      _$PlanEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlanEntityToJson(this);
}
