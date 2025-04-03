// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanEntity _$PlanEntityFromJson(Map<String, dynamic> json) => PlanEntity(
      id: (json['id'] as num).toInt(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      totalBudget: (json['total_budget'] as num).toDouble(),
      createAt: DateTime.parse(json['create_at'] as String),
      summaryTranfer: (json['summary_tranfer'] as num).toDouble(),
      summarySaving: (json['summary_saving'] as num).toDouble(),
      summaryOther: (json['summary_other'] as num).toDouble(),
    );

Map<String, dynamic> _$PlanEntityToJson(PlanEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'total_budget': instance.totalBudget,
      'create_at': instance.createAt.toIso8601String(),
      'summary_tranfer': instance.summaryTranfer,
      'summary_saving': instance.summarySaving,
      'summary_other': instance.summaryOther,
    };
