abstract class BlocParentState {}

class BlocParentInitialState extends BlocParentState {}

class BlocParentLoadingState extends BlocParentState {}

class BlocParentStateComplete extends BlocParentState {}

class BlocParentErrorState extends BlocParentState {
  final String message;
  BlocParentErrorState(this.message);
}
