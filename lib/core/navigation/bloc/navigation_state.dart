abstract class NavigationState {}

class NavigationInitial extends NavigationState {
  final int selectedIndex;

  NavigationInitial(this.selectedIndex);
}

class NavigationUpdated extends NavigationState {
  final int tabIndex;

  NavigationUpdated(this.tabIndex);
}
