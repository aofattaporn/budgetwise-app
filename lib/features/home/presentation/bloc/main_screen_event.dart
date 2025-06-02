abstract class MainScreenEvent {}

class TabScreenEvent extends MainScreenEvent {
  final String tabName;
  TabScreenEvent({required this.tabName});
}
