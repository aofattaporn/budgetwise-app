import 'package:flutter/widgets.dart';

abstract class PlanDetailState {
  final DateTime? startDate;
  final DateTime? endDate;
  final TextEditingController amount;

  PlanDetailState(
      {required this.startDate, required this.endDate, required this.amount});
}

class PlanDetailInitial extends PlanDetailState {
  PlanDetailInitial(
      {required super.startDate,
      required super.endDate,
      required super.amount});
}

class PlanUpdatedState extends PlanDetailState {
  PlanUpdatedState(
      {required super.startDate,
      required super.endDate,
      required super.amount});
}
