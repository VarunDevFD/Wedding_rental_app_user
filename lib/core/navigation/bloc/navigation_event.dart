abstract class NavigationEvent {}

class TabChange extends NavigationEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
