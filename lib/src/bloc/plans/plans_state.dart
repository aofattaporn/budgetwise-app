import 'package:budget_wise/src/data/models/planning_model.dart';

sealed class PlansState {}

// Initial state when nothing has happened yet
final class InitialState extends PlansState {}

// state : get salary
final class GetPlanSuccess extends PlansState {
  final List<Planning> data;
  GetPlanSuccess(this.data);
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
  final List<Planning> data;
  CreatePlanSuccess(this.data);
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
