// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_monthly_budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanMonthlyBudget _$PlanMonthlyBudgetFromJson(Map<String, dynamic> json) =>
    _PlanMonthlyBudget(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      amountLimit: (json['amountLimit'] as num).toDouble(),
      isArchived: json['isArchived'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      summaryTransactions: (json['summaryTransactions'] as List<dynamic>)
          .map((e) => SummaryTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanMonthlyBudgetToJson(_PlanMonthlyBudget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'amountLimit': instance.amountLimit,
      'isArchived': instance.isArchived,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'summaryTransactions': instance.summaryTransactions,
    };

_SummaryTransaction _$SummaryTransactionFromJson(Map<String, dynamic> json) =>
    _SummaryTransaction(
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$SummaryTransactionToJson(_SummaryTransaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
    };
