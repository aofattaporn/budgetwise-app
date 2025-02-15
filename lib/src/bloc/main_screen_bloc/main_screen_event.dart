sealed class MainScreenEvent {
  MainScreenEvent();
}

final class TabScreenEvent extends MainScreenEvent {
  final String tabName;
  TabScreenEvent({required this.tabName});
}
