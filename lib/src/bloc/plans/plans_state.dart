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
