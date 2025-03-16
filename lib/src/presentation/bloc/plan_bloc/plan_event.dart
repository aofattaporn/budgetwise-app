import 'package:equatable/equatable.dart';

abstract class PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrentMonthPlan extends PlanEvent {}
