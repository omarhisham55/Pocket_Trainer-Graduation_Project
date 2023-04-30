abstract class MainStateManager{}

class InitialState extends MainStateManager{}

class GetPaymentMethod extends MainStateManager{}

class IsSilverClickedState extends MainStateManager{}

class IsGoldClickedState extends MainStateManager{}

class RadioButtonPaymentState extends MainStateManager{}

class SignUpState extends MainStateManager{}

class LoginState extends MainStateManager{}

class HomePageState extends MainStateManager{}

class ChangeSearchState extends MainStateManager{
  List filteredList;
  ChangeSearchState({
    required this.filteredList
});
}

class DeleteButtonState extends MainStateManager{}

class DietRequirements extends MainStateManager{}

class DropDownState extends MainStateManager{}

class PieChartState extends MainStateManager{
  int index;
  PieChartState({required this.index});
}
