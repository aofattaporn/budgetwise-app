import 'package:equatable/equatable.dart';

abstract class PlanAllMonthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllPlans extends PlanAllMonthEvent {}
