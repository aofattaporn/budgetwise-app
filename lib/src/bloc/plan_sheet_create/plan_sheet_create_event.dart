// Event
import 'package:equatable/equatable.dart';

abstract class PlanSheetCreateEvent extends Equatable {
  const PlanSheetCreateEvent();

  @override
  List<Object> get props => [];
}

class SetIconEvent extends PlanSheetCreateEvent {
  const SetIconEvent();
}
