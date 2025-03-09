import 'package:flutter/widgets.dart';

abstract class PlanDetailEvent {}

class InitializePlanningDetailEvent extends PlanDetailEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final TextEditingController amount;

  InitializePlanningDetailEvent({
    required this.startDate,
    required this.endDate,
    required this.amount,
  });
}

class UpdateStartDateEvent extends PlanDetailEvent {
  final DateTime newDate;
  UpdateStartDateEvent(this.newDate);
}

class UpdateEndDateEvent extends PlanDetailEvent {
  final DateTime newDate;
  UpdateEndDateEvent(this.newDate);
}

class UpdateAmountEvent extends PlanDetailEvent {
  final TextEditingController amount;
  UpdateAmountEvent(this.amount);
}

class SavePlanningEvent extends PlanDetailEvent {}
