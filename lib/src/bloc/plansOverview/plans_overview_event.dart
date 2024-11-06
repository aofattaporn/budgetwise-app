// Event
import 'package:equatable/equatable.dart';

abstract class PlansOverviewEvent extends Equatable {
  const PlansOverviewEvent();

  @override
  List<Object> get props => [];
}

class LoadPlans extends PlansOverviewEvent {}
