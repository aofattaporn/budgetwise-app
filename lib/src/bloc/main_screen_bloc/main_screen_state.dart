sealed class MainScreenState {
  final String tabScreen;
  MainScreenState({required this.tabScreen});
}

// Initial state when nothing has happened yet
final class InitialState extends MainScreenState {
  InitialState({required super.tabScreen});
}

final class TabSuccessState extends MainScreenState {
  TabSuccessState({required super.tabScreen});
}

final class ErrorState extends MainScreenState {
  ErrorState({required super.tabScreen});
}
