import 'package:budget_wise/src/domain/models/plan_dto.dart';

class PlanEntity {
  final int? id;
  final DateTime startDate;
  final DateTime endDate;
  final double totalBudget;
  final DateTime createAt;
  final double summaryTranfer;
  final double summarySaving;
  final double summaryOther;

  PlanEntity({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
    required this.createAt,
    required this.summaryTranfer,
    required this.summarySaving,
    required this.summaryOther,
  });

  factory PlanEntity.fromJson(Map<String, dynamic> json) {
    return PlanEntity(
      id: json['id'] as int?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      totalBudget: (json['total_budget'] as num).toDouble(),
      createAt: DateTime.parse(json['create_at'] as String),
      summaryTranfer: (json['summary_tranfer'] as num).toDouble(),
      summarySaving: (json['summary_saving'] as num).toDouble(),
      summaryOther: (json['summary_other'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_budget': totalBudget,
      'create_at': createAt.toIso8601String(),
      'summary_tranfer': summaryTranfer,
      'summary_saving': summarySaving,
      'summary_other': summaryOther,
    };
  }

  static Map<String, dynamic> toJsonInsert(PlanDto plan) {
    return {
      'start_date': plan.startDate.toIso8601String(),
      'end_date': plan.endDate.toIso8601String(),
      'total_budget': plan.totalBudget,
      'create_at': plan.endDate.toIso8601String(),
    };
  }

  static Map<String, dynamic> toJsonUpdate(PlanDto plan) {
    return {
      'start_date': plan.startDate.toIso8601String(),
      'end_date': plan.endDate.toIso8601String(),
      'total_budget': plan.totalBudget,
      'update_at': DateTime.now().toIso8601String()
    };
  }
}
