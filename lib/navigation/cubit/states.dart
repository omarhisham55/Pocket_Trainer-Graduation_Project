
abstract class MainStateManager{}

class InitialState extends MainStateManager{}

class GetPaymentMethod extends MainStateManager{}

class IsSilverClickedState extends MainStateManager{}

class IsGoldClickedState extends MainStateManager{}

class RadioButtonPaymentState extends MainStateManager{}

class RadioButtonAddMealState extends MainStateManager{}

class SignUpState extends MainStateManager{}

class ChangeBoolState extends MainStateManager{}

class LoginState extends MainStateManager{}

class GymBodyState extends MainStateManager{}

class ChangeSearchState extends MainStateManager{
  List filteredList;
  ChangeSearchState({
    required this.filteredList
});
}

class DeleteButtonState extends MainStateManager{}

class Requirements extends MainStateManager{}

class DropDownState extends MainStateManager{
  String selectedValue;
  DropDownState({required this.selectedValue});
}

class PieChartState extends MainStateManager{
  int index;
  PieChartState({required this.index});
}

class HandleSlidingPanelState extends MainStateManager{}

class RemoveMealState extends MainStateManager{}

class RemoveExerciseState extends MainStateManager{}

class AddMealState extends MainStateManager{}

class AddExerciseState extends MainStateManager{}

class GetExerciseDataToPanel extends MainStateManager{}

class FilterState extends MainStateManager{}

class ChangeDateState extends MainStateManager{}

class CreateWorkoutPlan extends MainStateManager{}

class ChangeUserStats extends MainStateManager{}

class EditUser extends MainStateManager{}

class GetUser extends MainStateManager{}

class StretchesCountDown extends MainStateManager{}