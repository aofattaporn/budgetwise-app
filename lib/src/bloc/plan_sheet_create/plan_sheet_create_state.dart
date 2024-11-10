// State
import 'package:equatable/equatable.dart';

abstract class PlanSheetCreateState extends Equatable {
  const PlanSheetCreateState();

  @override
  List<Object> get props => [];
}

class PickerMonthSuccess extends PlanSheetCreateState {
  const PickerMonthSuccess();
}

class PlansOverviewInitial extends PlanSheetCreateState {}
