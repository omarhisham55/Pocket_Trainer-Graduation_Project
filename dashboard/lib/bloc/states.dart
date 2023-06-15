abstract class DashboardState {}

class InitialState extends DashboardState {}

class ChangeMenuState extends DashboardState {
  bool? isExpanded;
  ChangeMenuState({this.isExpanded});
}

class ChangePageWidth extends DashboardState{}
class GetTable extends DashboardState{}