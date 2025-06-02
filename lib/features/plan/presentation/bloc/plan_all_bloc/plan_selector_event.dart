import 'package:budget_wise/features/plan/data/models/plan_dto.dart';

abstract class PlanSelectorEvent {}

class FetchAllMonthPlanEvent extends PlanSelectorEvent {}

class InsertNewPlan extends PlanSelectorEvent {
  final PlanDto planDto;
  InsertNewPlan({required this.planDto});
}
