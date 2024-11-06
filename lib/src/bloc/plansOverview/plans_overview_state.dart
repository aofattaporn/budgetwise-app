// State
import 'package:equatable/equatable.dart';

abstract class PlansOverviewState extends Equatable {
  const PlansOverviewState();

  @override
  List<Object> get props => [];
}

class PlansOverviewInitial extends PlansOverviewState {}

class PlansOverviewLoading extends PlansOverviewState {}

class PlansOverviewLoaded extends PlansOverviewState {
  final List<String> plans; // Replace with your actual data model

  const PlansOverviewLoaded(this.plans);

  @override
  List<Object> get props => [plans];
}

class PlansOverviewError extends PlansOverviewState {
  final String message;

  const PlansOverviewError(this.message);

  @override
  List<Object> get props => [message];
}
