import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/information/viewExercises.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/nutrition_dialog_data.dart';
import '../../data/offers.dart';
import '../../pages/gym/gym.dart';
import '../../pages/home/home.dart';
import '../../pages/information/information.dart';
import '../../pages/nutrition/diet_recommended_plan.dart';
import '../../pages/nutrition/nutrition.dart';
import '../../pages/profile/profile.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../animationNavigation.dart';

class CubitManager extends Cubit<MainStateManager> {
  CubitManager() : super(InitialState());

  static CubitManager get(context) => BlocProvider.of<CubitManager>(context);
  //signUp changeable
  bool isPassword = true;
  bool isConfirmPassword = true;
  int signUpGroupRadio = 1;
  var radioVal = 'gender';
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  bool signup = false;

  void isPasswordCheck() {
    isPassword = !isPassword;
    emit(SignUpState());
  }

  void isConfirmPasswordCheck() {
    isConfirmPassword = !isConfirmPassword;
    emit(SignUpState());
  }

  void selectGender(value) {
    signUpGroupRadio = value;
    emit(SignUpState());
  }

  void pushToLogin() {
    signup = !signup;
    loginKey.currentState!.reset();
    signupKey.currentState!.reset();
    emit(LoginState());
  }

  //Premium plans boolean card
  bool isClicked = true;

  void isSliverClicked() {
    isClicked = true;
    emit(IsSilverClickedState());
  }

  void isGoldClicked() {
    isClicked = false;
    emit(IsGoldClickedState());
  }

  //payment checkBox
  int paymentGroupRadio = 1;

  void changeRadioButton(value) {
    paymentGroupRadio = value;
    emit(RadioButtonPaymentState());
  }

  //data transferred to payment method
  List<String> paymentMethod() {
    List<String> payment = [];
    if (isClicked) {
      payment.add(premiumPlansContent["Silver"]![0]);
      payment.add(premiumPlansContent["Silver"]![1]);
      payment.add(premiumPlansContent["Silver"]![2]);
      emit(GetPaymentMethod());
    } else {
      payment.add(premiumPlansContent["Gold"]![0]);
      payment.add(premiumPlansContent["Gold"]![1]);
      payment.add(premiumPlansContent["Gold"]![2]);
      emit(GetPaymentMethod());
    }
    return payment;
  }

  //Navigation
  int currentIndex = 2;
  late PersistentTabController controller =
      PersistentTabController(initialIndex: currentIndex);

  List<Widget> screens() {
    return [
      const Information(),
      const Gym(),
      const Home(),
      const Nutrition(),
      const Profile()
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.info),
        iconSize: 30,
        activeColorPrimary: BackgroundColors.button,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sports),
        iconSize: 30,
        activeColorPrimary: BackgroundColors.button,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        iconSize: 30,
        activeColorPrimary: BackgroundColors.button,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.nutritionix),
        iconSize: 30,
        activeColorPrimary: BackgroundColors.button,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.user),
        iconSize: 30,
        activeColorPrimary: BackgroundColors.button,
        inactiveColorPrimary: Colors.grey[300],
      ),
    ];
  }

  //HomePage content
  final List<SpecialOffer> specialOffer = SpecialOffer.offers();
  bool isFrontBody = true;

  void changeBody() {
    isFrontBody = !isFrontBody;
    emit(GymBodyState());
  }

  //search
  List<String> selectedFood = [];
  String searchText = "";
  bool isSearchOpened = false;
  final TextEditingController searchQuery = TextEditingController();
  void searchQueryMealListener(searchList) {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        searchText = "";
        buildSearchMealList(searchList);
      } else {
        searchText = searchQuery.text;
        print(searchText);
        buildSearchMealList(searchList);
      }
    });
  }
  void searchQueryExerciseListener(searchList) {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        searchText = "";
        buildSearchExerciseList(searchList);
      } else {
        searchText = searchQuery.text;
        print(searchText);
        buildSearchExerciseList(searchList);
      }
    });
  }
  List buildSearchMealList(searchList) {
      if (searchText.isEmpty) {
        emit(ChangeSearchState(filteredList: searchList));
        return searchList;
      } else {
        List filteredList = [];
          for (int i = 0; i < searchList.length; i++) {
            if (searchList[i].name.toLowerCase().contains(
                searchText.toLowerCase())) {
              filteredList.add(searchList[i]);
            }
          }
        print("length after filter ${filteredList.length}");
        print("meal name filter ${filteredList[0].name}");
        emit(ChangeSearchState(filteredList: filteredList));
        return filteredList;
      }
  }
  List buildSearchExerciseList(searchList) {
      if (searchText.isEmpty) {
        emit(ChangeSearchState(filteredList: searchList));
        return searchList;
      } else {
        List filteredList = [];
          for (int i = 0; i < searchList.length; i++) {
            if (searchList[i].exerciseName.toLowerCase().contains(
                searchText.toLowerCase())) {
              filteredList.add(searchList[i]);
            }
          }
        print("length after filter ${filteredList.length}");
        print("exercise name filter ${filteredList[0].exerciseName}");
        emit(ChangeSearchState(filteredList: filteredList));
        return filteredList;
      }
  }
  void changeSearchIcon({searchList}){
    isSearchOpened = !isSearchOpened;
    emit(ChangeSearchState(filteredList: searchList));
  }

  //Nutrition

  bool deleteButtonFood = false;
  //panel to add meals
  PanelController addMealController = PanelController();
  //panel to show list of selected meals
  PanelController foodListPanel = PanelController();
  int addNumber = 0;

  void dietRequirements(isDietTaken){
    isDietTaken = true;
    emit(DietRequirements());
  }
  void deleteButton(){
    deleteButtonFood = !deleteButtonFood;
    emit(DeleteButtonState());
  }
  void dropDownSelect(value, selectedValue){
    selectedValue = value;
    emit(DropDownState(selectedValue: selectedValue));
  }
  bool isChecked = false;
  bool disableButton(){
    isChecked = true;
    emit(RadioButtonAddMealState());
    return isChecked;
  }
  int pieChart(event,pieTouchResponse, touchedIndex){
    if (!event.isInterestedForInteractions
        || pieTouchResponse == null
        || pieTouchResponse.touchedSection == null
    ) {
      touchedIndex = -1;
    }
    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    return touchedIndex;
  }

  void slidingPanel(controller){
    controller.isPanelOpen
        ? controller.close()
        : controller.open();
    emit(HandleSlidingPanelState());
  }
  List<String> removeMeal(List<String> selectedMeal, int index){
    selectedMeal.removeAt(index);
    emit(RemoveMealState());
    return selectedMeal;
  }

  //Gym
  String exercisePanelName = "";
  String exercisePanelType = "";
  void addExerciseName(name, type){
    exercisePanelName = name;
    exercisePanelType = type;
    emit(AddExerciseState());
  }


  List<QudsPopupMenuBase> getSearchFilterItems() {
    return List.generate(dropDownFirstLevel.length, (index) {
      return QudsPopupMenuSection(
          titleText: dropDownFirstLevel[index],
          subItems: List.generate(dropDownSecondLevel.length, (i) {
            return QudsPopupMenuItem(
                title: Text(dropDownSecondLevel[i]),
                onPressed: () {
                    dropDownHint = dropDownFirstLevel[index];
                    dropDownSubHint = dropDownSecondLevel[i];
                    //to change number of exercises in grid view according to filter
                    for (var element in dropDownFirstLevel) {
                      if (dropDownHint == "All Exercises") {
                        // searchList = exerciseTitle;
                      } else if (dropDownHint == element) {
                        // searchList = getExerciseName(element);
                      }
                    }
                  print(dropDownHint);
                  print(dropDownSubHint);
                });
          }));
    });
  }

  List<String> dropDownFirstLevel = [
    "All Exercises", "Chest", "Back",
    "Shoulders", "Arms", "Legs"
  ];
  List<String> dropDownSecondLevel = [
    "All techniques", "Cables", "Dumbbells",
    "Body Weight", "Barbell", "Machines"
  ];
  String dropDownHint = "All Exercises";
  String dropDownSubHint = "All techniques";
  void changeFilter(){

    emit(FilterState());
  }
}