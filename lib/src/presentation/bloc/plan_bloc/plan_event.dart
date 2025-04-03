import 'package:equatable/equatable.dart';

abstract class PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrentMonthPlan extends PlanEvent {}

class FetchtPlanByMonth extends PlanEvent {}

class FetchtPlanByMId extends PlanEvent {
  final int id;

  FetchtPlanByMId({required this.id});
}
