// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:email_otp/email_otp.dart';
import 'package:final_packet_trainer/data/gym_dialog_data.dart';
import 'package:final_packet_trainer/poseDetectionModel/poseDetection.dart';
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
import '../../main.dart';
import '../../pages/gym/gym.dart';
import '../../pages/home/home.dart';
import '../../pages/information/information.dart';
import '../../pages/nutrition/nutrition.dart';
import '../../pages/profile/profile.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CubitManager extends Cubit<MainStateManager> {
  CubitManager() : super(InitialState());

  //panel to add meals
  PanelController addMealController = PanelController();

  int addNumber = 0;
  GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();
  TextEditingController confirmPassController = TextEditingController();
  late PersistentTabController controller =
      PersistentTabController(initialIndex: currentIndex);

  int currentDateIndex = 0;
  //Navigation
  int currentIndex = 2;

  //Nutrition

  bool deleteButtonFood = false;

  List<String> dropDownFirstLevel = [
    "All Exercises",
    "Chest",
    "Back",
    "Shoulders",
    "Biceps",
    "Triceps",
    "Legs"
  ];

  String dropDownHint = "All Exercises";
  List<String> dropDownSecondLevel = [
    "All techniques",
    "Cables",
    "Dumbbells",
    "Body Weight",
    "Barbell",
    "Machines"
  ];

  String dropDownSubHint = "All techniques";
  TextEditingController emailController = TextEditingController();
  //Gym
  final exercisePanelController = PanelController();

  String exercisePanelId = "";
  String exercisePanelImage = "";
  // void changeFilter({type, technique}){
  //   emit(FilterState(exerciseType: type));
  // }

  //add meal to database
  String exercisePanelName = "";

  String exercisePanelReps = "";
  String exercisePanelSets = "";
  String exercisePanelType = "";
  String exerciseType = "";
  //panel to show list of selected meals
  PanelController foodListPanel = PanelController();

  bool fromHome = false;
  bool isChecked = false;
  //Premium plans boolean card
  bool isClicked = true;

  bool isConfirmPassword = true;
  bool isFrontBody = true;
  //signUp changeable
  bool isPassword = true;

  bool isSearchOpened = false;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();
  TextEditingController passController = TextEditingController();
  //payment checkBox
  int paymentGroupRadio = 1;

  var radioVal = 'gender';
  final TextEditingController searchQuery = TextEditingController();
  String searchText = "";
  //date
  DateTime selectedDate = DateTime.now();

  //search
  List<String> selectedFood = [];

  List selectedMeals = [];
  String selectedValue = "select meal time";
  int signUpGroupRadio = 1;
  bool signup = false;
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  //HomePage content
  final List<SpecialOffer> specialOffer = SpecialOffer.offers();

//stretches countdown
  int timeLeft = 0;

  //login?signUp
  List<String> title = ["Login", "Sign Up"];

  TextEditingController userController = TextEditingController();
  String weekdayOfIndex = "";

  static CubitManager get(context) => BlocProvider.of<CubitManager>(context);

  Future<void> falseEmit() async {
    emit(InitialState());
  }

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
    emit(LoginState());
  }

  void isSliverClicked() {
    isClicked = true;
    emit(IsSilverClickedState());
  }

  void isGoldClicked() {
    isClicked = false;
    emit(IsGoldClickedState());
  }

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

  void changeBody() {
    isFrontBody = !isFrontBody;
    emit(GymBodyState());
  }

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

  void requirements(requirements) {
    requirements = true;
    emit(Requirements());
  }

  void changeToNotEmpty() {
    if (User.currentUser!.workoutPlan!.values.isEmpty) {
      isWorkoutPlanEmpty = true;
    } else {
      isWorkoutPlanEmpty = false;
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
        id: user['_id'],
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
  // Future editProfile({
  //   required BuildContext context,
  //   String? username,
  //   String? email,
  //   String? password,
  //   File? imageData,
  // }) async {
  //   print('edit profile opened $username');
  //   print('loloa ${User.currentUser!.id}');

  //   final profile = await http.put(
  //       Uri.parse('$url/edit/profile/${User.currentUser!.id}'),
  //       headers: {
  //         "Authorization": "Bearer ${User.token}",
  //         "Access-Control-Allow-Origin": "$url/*"
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'name': username,
  //         'email': email,
  //         'password': password,
  //       }));
  //   // .then((value) => print('success ${value.statusCode}, ${value.body}'))
  //   // .catchError((e) => print('error at $e'));
  //   if (profile.statusCode == 200) {
  //     var user = json.decode(profile.body);
  //     print(user);
  //     getProfile(context).then((v) {
  //       print(v['name']);
  //       emit(EditUser());
  //     });
  //     return user;
  //   } else {
  //     throw Exception("Failed to load data ${profile.body}");
  //   }
  // }

  Color changeColor(path) {
    if (path == ('')) {
      // emit(AddPhoto());
      return Colors.grey;
    } else {
      emit(AddPhoto());
      return BackgroundColors.background;
    }
  }

  Future deletePhoto(context) async {
    var photo = await http.patch(Uri.parse('$url/delete/profile/photo'),
        headers: {
          "Authorization": "Bearer ${User.token}",
          "Access-Control-Allow-Origin": "$url/*"
        });
    if (photo.statusCode != 200) {
      toastError(context: context, text: photo.body);
    } else {
      toastSuccess(context: context, text: photo.body);
    }
    await getProfile(context);
    emit(DeletePhoto());
  }

  Future editProfile({
    required BuildContext context,
    String? username,
    String? email,
    String? password,
    File? imageData,
  }) async {
    print('edit profile opened $username');
    print('loloa ${User.currentUser!.id}');

    var request = http.MultipartRequest(
        'PUT', Uri.parse('$url/edit/profile/${User.currentUser!.id}'));
    request.headers["Authorization"] = "Bearer ${User.token}";
    request.headers["Access-Control-Allow-Origin"] = "$url/*";

    if (username != null) {
      request.fields['name'] = username;
    }
    if (email != null) {
      request.fields['email'] = email;
    }
    if (password != null) {
      request.fields['password'] = password;
    }
    if (imageData != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        imageData.path,
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var user = json.decode(responseBody);
      print(user);
      await getProfile(context);
      emit(EditUser());
      return user;
    } else {
      throw Exception(
          "Failed to load data ${response.reasonPhrase} ${response.statusCode}");
    }
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

  void onSelectedDate(date) {
    selectedDate = date;
    emit(ChangeDateState());
  }

  void getWeekday(index) {
    weekdayOfIndex = daysOfTraining[index];
    // print('$weekdayOfIndex of ${index}');
    emit(ChangeDateState());
  }

  void changeIndex(index) {
    currentDateIndex = index;
    emit(ChangeDateState());
  }

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
  Future<Map<String, dynamic>> createWorkoutPlan(context, requirements) async {
    print(User.token);
    var workout = await http.post(
      Uri.parse('$url/wourkoutplan-recommendation'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "$url/*"
      },
      body: jsonEncode(<String, dynamic>{
        'level': requirements[0],
        'goal': requirements[1],
        'training_location': requirements[3],
        'HWlist': {'height': requirements[4][0], 'weight': requirements[4][1]},
        'workingOffDays': {
          'Day1': requirements[2][0],
          'Day2': requirements[2][1],
          'Day3': requirements[2][2],
          'Day4': requirements[2][3],
          'Day5': requirements[2][4],
          'Day6': requirements[2][5],
          'Day7': requirements[2][6],
        }
      }),
    );
    if (workout.statusCode == 200) {
      var data = json.decode(workout.body);
      getProfile(context);
      getWorkoutPlan();
      print("created workout plan $data");
      emit(CreateWorkoutPlan());
      return data;
    } else {
      throw Exception(
          "Failed to load data ${workout.statusCode} ${workout.body}");
    }
  }

  openCamera(camera, model) {
    camera = true;
    model = true;
    emit(OpenCamera());
  }
}
