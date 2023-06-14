// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:email_otp/email_otp.dart';
import 'package:final_packet_trainer/data/gym_dialog_data.dart';
import 'package:http/http.dart' as http;
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/offers.dart';
import '../../data/userData.dart';
import '../../pages/gym/gym.dart';
import '../../pages/home/home.dart';
import '../../pages/information/information.dart';
import '../../pages/nutrition/nutrition.dart';
import '../../pages/profile/profile.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CubitManager extends Cubit<MainStateManager> {
  CubitManager() : super(InitialState());

  static CubitManager get(context) => BlocProvider.of<CubitManager>(context);

  Future<void> falseEmit() async {
    emit(InitialState());
  }

  //signUp changeable
  bool isPassword = true;
  bool isConfirmPassword = true;
  int signUpGroupRadio = 1;
  var radioVal = 'gender';
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();
  bool signup = false;
  bool fromHome = false;
  void changeBool(value) {
    value = !value;
    fromHome = value;
    print("value = $value");
    print("from home = $fromHome");
    emit(ChangeBoolState());
  }

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
    // loginKey.currentState!.reset();
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

  //login?signUp
  List<String> title = ["Login", "Sign Up"];
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

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
        if (searchList[i]
            .name
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          filteredList.add(searchList[i]);
        }
      }
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
        if (searchList[i]
            .exerciseName
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          filteredList.add(searchList[i]);
        }
      }
      emit(ChangeSearchState(filteredList: filteredList));
      return filteredList;
    }
  }

  void changeSearchIcon({searchList}) {
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

  void requirements(requirements) {
    requirements = true;
    emit(Requirements());
  }

  void changeToNotEmpty() {
    for (var workoutList in User.currentUser!.workoutPlan!.values) {
      if (workoutList.isNotEmpty) {
        isWorkoutPlanEmpty = false;
        continue;
      }
    }
    emit(Requirements());
  }

  void deleteButton({staticBool}) {
    deleteButtonFood = staticBool ?? !deleteButtonFood;
    emit(DeleteButtonState());
  }

  void dropDownSelect(value, selectedValue) {
    selectedValue = value;
    emit(DropDownState(selectedValue: selectedValue));
  }

  bool isChecked = false;
  bool disableButton() {
    isChecked = true;
    emit(RadioButtonAddMealState());
    return isChecked;
  }

  int pieChart(event, pieTouchResponse, touchedIndex) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null) {
      touchedIndex = -1;
    }
    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    return touchedIndex;
  }

  void slidingPanel(controller) {
    controller.isPanelOpen ? controller.close() : controller.open();
    emit(HandleSlidingPanelState());
  }

  List selectedMeals = [];
  String selectedValue = "select meal time";

  //add meal to database
  Future<void> addMeals({required String mealId}) async {
    final response = await http.post(
      Uri.parse('$url/add-meal-to-nutritionPlan/$mealId'),
      headers: {"Authorization": "Bearer ${User.token}"},
    );
    if (response.statusCode == 200) {
      print('Meal added to Nutrition Plan ${response.body}');
      print('Meal added to Nutrition Plan ${response.statusCode}');
    } else {
      throw Exception(
          'Failed to add meal to Nutrition Plan ${response.statusCode}');
    }
    emit(AddMealState());
  }

  void addMeal(context, selectedValue) {
    if (selectedMeals.isNotEmpty) {
      print(selectedMeals);
      final futures = selectedMeals.map((meal) => addMeals(mealId: meal.id));
      Future.wait(futures)
          .then((values) => toastSuccess(
              context: context,
              text: "Meals added to $selectedValue",
              duration: 3))
          .catchError((e) {
        print("lolo ${e.runtimeType}");
      });
      addMealController.close();
      emit(AddMealState());
    } else {
      showSnackBar(context: context, text: "select meals");
      print("select meals");
    }
  }

  //delete meal from database
  Future<void> deleteMeals({required String mealId}) async {
    final response = await http.post(
      Uri.parse('$url/delete-meal-from-nutritionPlan/$mealId'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      print('Meal deleted from Nutrition Plan ${response.body}');
      print('Meal deleted from Nutrition Plan ${response.statusCode}');
    } else {
      throw Exception(
          'Failed to delete meal from Nutrition Plan ${response.statusCode}');
    }
    emit(RemoveMealState());
  }

  void removeMeal(List selectedMeal, int index) {
    selectedMeal.removeAt(index);
    emit(RemoveMealState());
  }

  //Gym
  final exercisePanelController = PanelController();

  String exerciseType = "";
  List<QudsPopupMenuBase> getSearchFilterItems(searchList) {
    return List.generate(dropDownFirstLevel.length, (index) {
      return QudsPopupMenuSection(
          titleText: dropDownFirstLevel[index],
          subItems: List.generate(dropDownSecondLevel.length, (i) {
            return QudsPopupMenuItem(
                title: Text(dropDownSecondLevel[i]),
                onPressed: () {
                  dropDownHint = dropDownFirstLevel[index];
                  dropDownSubHint = dropDownSecondLevel[i];
                  if (dropDownHint == "All Exercises") {
                    exerciseType = "";
                  } else {
                    exerciseType = dropDownHint;
                  }
                  emit(FilterState());
                });
          }));
    });
  }

  List<String> dropDownFirstLevel = [
    "All Exercises",
    "Chest",
    "Back",
    "Shoulders",
    "Biceps",
    "Triceps",
    "Legs"
  ];
  List<String> dropDownSecondLevel = [
    "All techniques",
    "Cables",
    "Dumbbells",
    "Body Weight",
    "Barbell",
    "Machines"
  ];
  String dropDownHint = "All Exercises";
  String dropDownSubHint = "All techniques";
  // void changeFilter({type, technique}){
  //   emit(FilterState(exerciseType: type));
  // }

  //add meal to database
  String exercisePanelName = "";
  String exercisePanelType = "";
  String exercisePanelId = "";
  String exercisePanelImage = "";
  String exercisePanelSets = "";
  String exercisePanelReps = "";
  void addExerciseName(id, name,
      {String? type, String? image, String? sets, String? reps}) {
    exercisePanelId = id;
    exercisePanelName = name.toString();
    exercisePanelType = type.toString();
    exercisePanelImage = image.toString();
    exercisePanelSets = sets.toString();
    exercisePanelReps = reps.toString();
    emit(GetExerciseDataToPanel());
  }

  Future<int> addWorkouts(
      {required BuildContext context, required String exerciseId}) async {
    print(exerciseId);
    int statusCode = 0;
    final response = await http.post(
      Uri.parse('$url/workoutplan/add/chest/exercise/$exerciseId'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Access-Control-Allow-Origin": "$url/*"
      },
      // body: jsonEncode({"test": exerciseId})
    );
    statusCode = response.statusCode;
    emit(AddExerciseState());
    return statusCode;
  }

  //delete workout from database
  // Future<void> deleteWorkouts({required String exerciseId}) async {
  //   final response = await http.post(
  //       Uri.parse('http://$ipConnectionAddress:3000/wourkoutplan-delete-back-exercise/$exerciseId'),
  //       headers: {"Authorization": "Bearer ${User.token}"},
  //   );
  //   if (response.statusCode == 200) {
  //     print('Exercise deleted from Workout Plan ${response.body}');
  //     print('Exercise deleted from Workout Plan ${response.statusCode}');
  //   } else {
  //     throw Exception('Failed to delete exercise from Workout Plan ${response.statusCode}');
  //   }
  //   emit(RemoveExerciseState());
  //
  // }
  Future<void> deleteWorkouts({required String exerciseId}) async {
    print(exerciseId);
    print(User.token);
    final response = await http.delete(
      Uri.parse('$url/wourkoutplan/delete/exercise'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "$url/*"
      },
      body: jsonEncode(<String, String>{
        'exerciseId': exerciseId,
      }),
    );
    if (response.statusCode == 200) {
      print('Exercise deleted from Workout Plan ${response.body}');
      print('Exercise deleted from Workout Plan ${response.statusCode}');
    } else {
      throw Exception(
          'Failed to delete exercise from Workout Plan ${response.statusCode}');
    }
    emit(RemoveExerciseState());
  }

  //get profile
  Future<Map<String, dynamic>> getProfile(context) async {
    final profile = await http.get(Uri.parse('$url/profile'),
        headers: {"Authorization": "Bearer ${User.token}"});
    if (profile.statusCode == 200) {
      var user = json.decode(profile.body);
      User.currentUser = User(
        name: user["name"] ?? "",
        email: user["email"] ?? "",
        password: user["password"] ?? "",
        urlPhotoData: user["photo"] != null && user["photo"]["data"] != null
            ? user["photo"]["data"]["data"].toString()
            : null.toString(),
        workoutPlan: user["workoutPlan"] ?? {},
        nutritionPlan: user["NutritionPlan"] ?? {},
      );
      // emit(GetUser());
      return user;
    } else {
      toastError(context: context, text: profile.body);
      throw Exception("Failed to load data");
    }
  }

  //edit profile
  Future editProfile({
    required BuildContext context,
    String? username,
    String? email,
    String? password,
    File? imageData,
  }) async {
    print('edit profile opened');
    final profile = await http.patch(Uri.parse('$url/edit/profile'),
        headers: {
          "Authorization": "Bearer ${User.token}",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "$url/*"
        },
        body: jsonEncode(<String, dynamic>{
          'name': username,
          'email': email,
          'password': password,
          'photo': {'contentType': 'image/jpg', 'data': imageData}
        })).then((value) => print('success ${value.statusCode}, ${value.body}')).catchError((e)=> print('error at $e'));
    // if (profile.statusCode == 200) {
    //   var user = json.decode(profile.body);
    //   getProfile(context).then((v) {
    //     emit(EditUser());
    //   });
    //   return user;
    // } else {
    //   throw Exception("Failed to load data ${profile.statusCode}");
    // }
  }

  //change Exercise
  Future changeExercise({required String oldId, required String newId}) async {
    print('oldid $oldId / newId $newId');
    var changeResponse = await http.patch(Uri.parse('$url/replace/exercise'),
        headers: {
          "Authorization": "Bearer ${User.token}",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "$url/*"
        },
        body: jsonEncode({'OldExerciseId': oldId, 'NewExerciseId': newId}));
    if (changeResponse.statusCode != 200) {
      emit(ChangeExercise());
      print('success');
    } else {
      print('error ${changeResponse.statusCode}');
    }
  }

  //date
  DateTime selectedDate = DateTime.now();
  void onSelectedDate(date) {
    selectedDate = date;
    emit(ChangeDateState());
  }

  String weekdayOfIndex = "";
  void getWeekday(index) {
    weekdayOfIndex = daysOfTraining[index];
    // print('$weekdayOfIndex of ${index}');
    emit(ChangeDateState());
  }

  int currentDateIndex = 0;
  void changeIndex(index) {
    currentDateIndex = index;
    emit(ChangeDateState());
  }

//stretches countdown
  int timeLeft = 0;
  void countdownTimer(int seconds) {
    Duration duration = const Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      timeLeft = seconds;
      if (timeLeft == 0) {
        print('done');
      }
      emit(StretchesCountDown());
    });
  }

//create workoutplan
  Future<Map<String, dynamic>> createWorkoutPlan(
      level, goal, trainingLocation) async {
    var workout = await http.post(
      Uri.parse('$url/wourkoutplan-recommendation'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "$url/*"
      },
      body: jsonEncode(<String, String>{
        'level': level,
        'goal': goal,
        'training_location': trainingLocation,
      }),
    );
    print("create plan dodo");
    if (workout.statusCode == 200) {
      var data = json.decode(workout.body);
      // print("created workout plan $data");
      // emit(CreateWorkoutPlan());
      return data;
    } else {
      throw Exception("Failed to load data ${workout.statusCode}");
    }
  }
}
