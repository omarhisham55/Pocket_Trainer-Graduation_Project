import 'package:circle_button/circle_button.dart';
import 'package:final_packet_trainer/pages/gym/gym.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../data/exerciseData.dart';
import '../../../navigation/navigation.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import 'AddExercise.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ExistExercise extends StatefulWidget {
  const ExistExercise({super.key});

  @override
  _ExistExerciseState createState() => _ExistExerciseState();
}

class _ExistExerciseState extends State<ExistExercise> {
  List<String> suggestions = [
    GetGymPageContent().gymPageContent.keys.elementAt(0),
    GetGymPageContent().gymPageContent.keys.elementAt(1),
    GetGymPageContent().gymPageContent.keys.elementAt(2)
  ];
  List<List<String>> warmUp = GetGymPageContent().getWarmUp()!;
  List<List<String>> exercise = GetGymPageContent().getExercise()!;
  List<List<String>> stretches = GetGymPageContent().getStretches()!;
  List<List<String>> allExercises = GetGymPageContent().getAllExercises();
  String exercisePanelName = "";
  String exercisePanelType = "";
  String suggestion = "Choose category";
  final panelController = PanelController();
  TextEditingController sets = TextEditingController();
  TextEditingController reps = TextEditingController();
  late List<String> exerciseType = getExerciseType();
  late List<String> exerciseName = [];
  late List<String> exerciseInfo = [];
  late List<String> exerciseImage = [];
  final TextEditingController searchQuery = TextEditingController();
  List<String> searchList = [];
  List<String> exerciseTitle = [];
  List<String> dropDownFirstLevel = [
    "All Exercises",
    "Chest",
    "Back",
    "Shoulders",
    "Arms",
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

  String searchText = "";
  Widget appBarTitle = const Text(
    "Exercise",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    for (var i = 0; i < allExercises.length; i++) {
      exerciseTitle.add(allExercises[i][0]);
    }
    searchList = exerciseTitle;
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        setState(() {
          searchText = "";
          buildSearchList();
        });
      } else {
        setState(() {
          searchText = searchQuery.text;
          buildSearchList();
        });
      }
    });
    for (var element in exerciseType) {
      // exerciseName.add(getExerciseName(element).toString());
      // exerciseImage
    }
    super.initState();
  }

  //search according to filter
  List<String> buildSearchList() {
      if (searchText.isEmpty && dropDownHint == "All Exercises" && dropDownSubHint == "All Techniques") {
        return searchList = exerciseTitle;
      }else{
        if(dropDownHint == "All Exercises"){
          searchList = exerciseTitle.where((element) => element.contains(searchText.toLowerCase())).toList();
        }else{
          for(var element in dropDownFirstLevel){
            if(dropDownHint == element){
              // searchList = getExerciseName(element).where((element) => element.contains(searchText.toLowerCase())).toList();
            }
          }
        }
        return searchList;
      }
  }


  void handleSearchEnd() {
    setState(() {
      actionIcon = const Icon(
        Icons.search,
        color: BackgroundColors.whiteBG,
      );
      appBarTitle = const Text(
        "Exercise",
        style: TextStyle(color: Colors.white),
      );
      searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundColors.background,
        appBar: AppBar(
            centerTitle: true,
            title: appBarTitle,
            backgroundColor: BackgroundColors.dialogBG,
            actions: <Widget>[
              IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (actionIcon.icon == Icons.search) {
                      actionIcon = const Icon(
                        Icons.close,
                        color: BackgroundColors.whiteBG,
                      );
                      appBarTitle = TextField(
                        controller: searchQuery,
                        style: const TextStyle(
                          color: BackgroundColors.whiteBG,
                        ),
                        decoration: const InputDecoration(
                            hintText: "Search here..",
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    } else {
                      handleSearchEnd();
                    }
                  });
                },
              ),
            ]),
        body: SlidingUpPanel(
          controller: panelController,
          maxHeight: height(context, .5),
          minHeight: height(context, 0),
          defaultPanelState: PanelState.CLOSED,
          body: Column(
            children: [
              Container(
                color: BackgroundColors.inkWellBG,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: QudsPopupButton(
                          tooltip: 'search filter',
                          items: getSearchFilterItems(),
                          child: subTitleText(
                              text: "$dropDownHint / $dropDownSubHint")),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      itemCount: searchList.length,
                      itemBuilder: (_, i) => exerciseCard(
                          function: () {
                            panelController.close();
                          },
                          image: GymImages.gymBg,
                          title: searchList[i],
                          addCardButton: true,
                          addFunction: () {
                            setState(() {
                              exercisePanelName = searchList[i];
                              exercisePanelType = allExercises.elementAt(exerciseTitle.indexOf(exercisePanelName))[1];
                            });
                            (panelController.isPanelClosed)
                                ? panelController.open()
                                : panelController.close();
                          })),
                ),
              )
            ],
          ),
          panelBuilder: (panelBuilder) => Container(
            decoration: const BoxDecoration(
                color: BackgroundColors.dialogBG,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText(text: "Add exercise"),
                  Row(
                    children: [
                      titleText(text: exercisePanelName),
                    ],
                  ),
                  Row(
                    children: [
                      subTitleText(text: exercisePanelType),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: BackgroundColors.whiteBG,
                    child: defaultDropDownMenu(
                        content: suggestions,
                        hintValue: suggestion,
                        hintColor: TextColors.blackText,
                        function: (value) {
                          setState(() {
                            suggestion = value!;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        color: BackgroundColors.whiteBG,
                        child: defaultTextFormField(
                            controller: sets,
                            hint: "Sets",
                            hintTexColor: TextColors.blackText,
                            textInputType: TextInputType.number,
                            textStyle: TextColors.blackText),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        color: BackgroundColors.whiteBG,
                        child: defaultTextFormField(
                            controller: reps,
                            hint: "Reps",
                            hintTexColor: TextColors.blackText,
                            textStyle: TextColors.blackText,
                            textInputType: TextInputType.number),
                      ),
                    ],
                  ),
                  DefaultButton(
                      function: () {
                        setState(() {
                          switch (suggestion) {
                            case "WarmUp":
                              // warmUp!.add([exerciseName, exerciseType]);
                              break;
                            case "Exercise":
                              exercise
                                  .add([exercisePanelName, exercisePanelType]);
                              break;
                            case "Stretches":
                              stretches
                                  .add([exercisePanelName, exercisePanelType]);
                              break;
                          }
                        });
                        homeNavigator(context, Navigation());
                      },
                      borderRadius: 20,
                      text: "Add")
                ],
              ),
            ),
          ),
        ));
  }
  List<QudsPopupMenuBase> getSearchFilterItems() {
    return List.generate(dropDownFirstLevel.length, (index) {
      return QudsPopupMenuSection(
          titleText: dropDownFirstLevel[index],
          subItems: List.generate(dropDownSecondLevel.length, (i) {
            return QudsPopupMenuItem(
                title: Text(dropDownSecondLevel[i]),
                onPressed: () {
                  setState(() {
                    dropDownHint = dropDownFirstLevel[index];
                    dropDownSubHint = dropDownSecondLevel[i];
                    //to change number of exercises in grid view according to filter
                    for(var element in dropDownFirstLevel){
                      if(dropDownHint == "All Exercises"){
                        searchList = exerciseTitle;
                      } else if(dropDownHint == element){
                        // searchList = getExerciseName(element);
                      }
                    }
                  });
                  print(dropDownHint);
                  print(dropDownSubHint);
                });
          })
      );
    });
  }
}
