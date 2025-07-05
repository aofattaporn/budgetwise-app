import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_monthly_budget.freezed.dart';
part 'plan_monthly_budget.g.dart';

@freezed
abstract class PlanMonthlyBudget with _$PlanMonthlyBudget {
  const factory PlanMonthlyBudget({
    required String id,
    required String userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required double amountLimit,
    required bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<SummaryTransaction> summaryTransactions,
  }) = _PlanMonthlyBudget;

  factory PlanMonthlyBudget.fromJson(Map<String, dynamic> json) =>
      _$PlanMonthlyBudgetFromJson(json);

  static PlanMonthlyBudget mock() => PlanMonthlyBudget(
        id: 'mock_id',
        userId: 'mock_user',
        name: 'Mock Plan',
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 12, 31),
        amountLimit: 1000.0,
        isArchived: false,
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 6, 1),
        summaryTransactions: [SummaryTransaction.mock()],
      );
}

@freezed
abstract class SummaryTransaction with _$SummaryTransaction {
  const factory SummaryTransaction({
    required double amount,
    required String type,
  }) = _SummaryTransaction;

  factory SummaryTransaction.fromJson(Map<String, dynamic> json) =>
      _$SummaryTransactionFromJson(json);

  static SummaryTransaction mock() => SummaryTransaction(
        amount: 100.0,
        type: 'expense',
      );
}
