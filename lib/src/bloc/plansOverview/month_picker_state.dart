// State
import 'package:equatable/equatable.dart';

abstract class PlansOverviewState extends Equatable {
  const PlansOverviewState();

  @override
  List<Object> get props => [];
}

class PickerMonthSuccess extends PlansOverviewState {
  const PickerMonthSuccess();
}

class PlansOverviewInitial extends PlansOverviewState {}
