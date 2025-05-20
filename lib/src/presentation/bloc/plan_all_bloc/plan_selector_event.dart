import 'package:budget_wise/src/domain/models/plan_dto.dart';

abstract class PlanSelectorEvent {}

class FetchAllMonthPlanEvent extends PlanSelectorEvent {}

class InsertNewPlan extends PlanSelectorEvent {
  final PlanDto planDto;
  InsertNewPlan({required this.planDto});
}
