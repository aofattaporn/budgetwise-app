import 'package:budget_wise/src/domain/models/plan_item_dto.dart';

class PlanItemEntity {
  final String id;
  final int planId;
  final String title;
  final double usage;
  final double planAmount;
  final String category;
  final String iconName;
  final DateTime createdAt;

  PlanItemEntity({
    required this.id,
    required this.planId,
    required this.title,
    required this.usage,
    required this.planAmount,
    required this.category,
    required this.iconName,
    required this.createdAt,
  });

  factory PlanItemEntity.fromJson(Map<String, dynamic> json) {
    return PlanItemEntity(
      id: json['id'] as String,
      planId: json['plan_id'] as int,
      title: json['title'] as String,
      usage: (json['usage'] as num).toDouble(),
      planAmount: (json['plan_amount'] as num).toDouble(),
      category: json['category'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      iconName: json['icon_name'] as String,
    );
  }

  static Map<String, dynamic> toJsonInsert(PlanItemDto planDto) {
    return {
      'plan_id': planDto.planId,
      'title': planDto.title,
      'usage': 0,
      'plan_amount': planDto.planAmount,
      'category': planDto.category,
      'icon_name': planDto.iconName,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  static Map<String, dynamic> toJsonUpdate(PlanItemDto planDto) {
    return {
      'title': planDto.title,
      'plan_amount': planDto.planAmount,
      'category': planDto.category,
      'icon_name': planDto.iconName,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'title': title,
      'usage': usage,
      'plan_amount': planAmount,
      'category': category,
      'icon_name': iconName,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
