// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanItemEntity _$PlanItemEntityFromJson(Map<String, dynamic> json) =>
    PlanItemEntity(
      planId: (json['plan_id'] as num).toInt(),
      title: DateTime.parse(json['title'] as String),
      usage: (json['usage'] as num).toDouble(),
      planAmount: (json['plan_amount'] as num).toDouble(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$PlanItemEntityToJson(PlanItemEntity instance) =>
    <String, dynamic>{
      'plan_id': instance.planId,
      'title': instance.title.toIso8601String(),
      'usage': instance.usage,
      'plan_amount': instance.planAmount,
      'category': instance.category,
    };
