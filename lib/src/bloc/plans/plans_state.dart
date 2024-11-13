import 'package:budget_wise/src/models/entity/planning_entity.dart';

sealed class PlansState {}

// Initial state when nothing has happened yet
final class InitialState extends PlansState {}

// state : plan loading process
final class PlanLoadingProcess extends PlansState {
  PlanLoadingProcess();
}

// state : plan not found
final class PlanNotFound extends PlansState {
  PlanNotFound();
}

// state : set plan data
final class SetPlanDataComplete extends PlansState {
  final List<PlanEntity> plansTranfer;
  final List<PlanEntity> plansSaving;
  final double totalPlanUsage;
  SetPlanDataComplete(this.plansTranfer, this.plansSaving, this.totalPlanUsage);
}

// state : get salary
final class GetCurrentSpendingSuccess extends PlansState {
  final List<PlanEntity> plans;
  final double totalPlanUsage;
  GetCurrentSpendingSuccess(this.plans, this.totalPlanUsage);
}

final class GetPlanLoading extends PlansState {
  GetPlanLoading();
}

final class GetPlanFailure extends PlansState {
  final String error;
  GetPlanFailure(this.error);
}

// state : get salary
final class CreatePlanSuccess extends PlansState {
  final List<PlanEntity> data;
  CreatePlanSuccess(this.data);
}

final class UpdatePlanSuccess extends PlansState {
  UpdatePlanSuccess();
}

final class CreatePlanLoading extends PlansState {
  CreatePlanLoading();
}

final class CreatePlanFailure extends PlansState {
  final String error;
  CreatePlanFailure(this.error);
}

// state : get salary
final class DeletePlanSuccess extends PlansState {
  DeletePlanSuccess();
}

final class DeletePlanLoading extends PlansState {
  DeletePlanLoading();
}

final class DeletePlanFailure extends PlansState {
  final String error;
  DeletePlanFailure(this.error);
}
