import 'package:budget_wise/src/domain/models/plan_info_dto.dart';
import 'package:budget_wise/src/domain/models/plan_item_summary.dart';

class PlanInfoSummary {
  final String id;
  final String userId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double amountLimit;
  final DateTime createdAt;
  final DateTime updatedAt;

  final double summaryExpense;
  final double summarySaving;
  final double sumaryOther;

  final List<PlanItemSummary> planItems;

  PlanInfoSummary({
    required this.id,
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.amountLimit,
    required this.createdAt,
    required this.updatedAt,
    required this.planItems,
    required this.summaryExpense,
    required this.summarySaving,
    required this.sumaryOther,
  });

  factory PlanInfoSummary.fromJson(Map<String, dynamic> json) {
    return PlanInfoSummary(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      amountLimit: (json['amount_limit'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      summaryExpense: (json['summary_expense'] as num).toDouble(),
      summarySaving: (json['summary_saving'] as num).toDouble(),
      sumaryOther: (json['summary_other'] as num).toDouble(),
      planItems: (json['plan_items'] as List<dynamic>)
          .map((e) => PlanItemSummary.fromJson(e))
          .toList(),
    );
  }

  factory PlanInfoSummary.fromInfo({
    required PlanInfoDto json,
    required double summaryExpense,
    required double summarySaving,
    required double sumaryOther,
  }) {
    return PlanInfoSummary(
      id: json.id,
      userId: json.userId,
      name: json.name,
      startDate: json.startDate,
      endDate: json.endDate,
      amountLimit: json.amountLimit,
      createdAt: json.createdAt,
      updatedAt: json.updatedAt,
      summaryExpense: summaryExpense,
      summarySaving: summarySaving,
      sumaryOther: sumaryOther,
      planItems: [],
    );
  }
}
