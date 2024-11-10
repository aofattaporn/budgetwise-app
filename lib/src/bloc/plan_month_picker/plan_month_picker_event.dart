// Event
import 'package:equatable/equatable.dart';

abstract class PlansOverviewEvent extends Equatable {
  const PlansOverviewEvent();

  @override
  List<Object> get props => [];
}

class SetMonthPickerEvent extends PlansOverviewEvent {
  final DateTime monthYear;

  const SetMonthPickerEvent({
    required this.monthYear,
  });
}
