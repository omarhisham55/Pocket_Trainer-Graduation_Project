import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../data/exerciseData.dart';
import '../../navigation/navigation.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../information/exerciseDetails.dart';

class ExistExercise extends StatelessWidget {
  ExistExercise({super.key});
  String suggestion = "Choose category";
  final panelController = PanelController();
  TextEditingController sets = TextEditingController();
  TextEditingController reps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List searchList = [];
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {
          if (s is ChangeSearchState) {
            searchList = s.filteredList;
            print(searchList);
          }else{
            getDataMapValues(allValues: true, key: "").then((value) {
              searchList = value;
            }).catchError((e){
              throw "Error at $e";
            });
          }
        },
        builder: (_, s) {
          CubitManager gym = CubitManager.get(_);
          return FutureBuilder(
            future: getDataMapValues(allValues: true, key: gym.exerciseType),
            builder: (_, snapshot){
              print("objectdata ${snapshot.data!.length}");
              if(snapshot.hasData){
                return Scaffold(
                  backgroundColor: BackgroundColors.background,
                  appBar: AppBar(
                      centerTitle: true,
                      title: (gym.isSearchOpened)
                          ? TextField(
                        controller: gym.searchQuery,
                        style: const TextStyle(
                          color: BackgroundColors.whiteBG,
                        ),
                        decoration: const InputDecoration(
                            hintText: "Search here..",
                            hintStyle: TextStyle(color: Colors.white)),
                      )
                          : titleText(text: "Add exercise"),
                      backgroundColor: BackgroundColors.dialogBG,
                      actions: <Widget>[
                        IconButton(
                          icon: (gym.isSearchOpened)
                              ? const Icon(
                            Icons.close,
                            color: BackgroundColors.whiteBG,
                          )
                              : const Icon(Icons.search,
                              color: BackgroundColors.whiteBG),
                          onPressed: () {
                            gym.changeSearchIcon(searchList: searchList);
                            if (!gym.isSearchOpened) gym.searchQuery.clear();
                            gym.searchQueryExerciseListener(searchList);
                          },
                        ),
                      ]
                  ),
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
                                  items: gym.getSearchFilterItems(searchList),
                                  child: subTitleText(
                                      text: "${gym.exerciseType} / ${gym.dropDownSubHint}")),
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
                                    (panelController.isPanelOpen) ? panelController.close()
                                        : pageNavigator(
                                        context,
                                        ExerciseDetails(
                                          exerciseName: searchList[i].exerciseName,
                                          exerciseInfo: searchList[i].exerciseDescription,
                                          exerciseImage: searchList[i].exerciseImage,
                                          exerciseType: searchList[i].exerciseType,
                                          exerciseTarget: searchList[i].exerciseTarget,
                                          exerciseTips: searchList[i].exerciseTips,
                                          exerciseRepetition: searchList[i].exerciseRepetition,
                                          exerciseSets: searchList[i].exerciseSets,
                                        ));
                                  },
                                  width: width(context, .5),
                                  image: searchList[i].exerciseImage,
                                  title: searchList[i].exerciseName,
                                  addCardButton: true,
                                  addFunction: () {
                                    gym.addExerciseName(searchList[i].exerciseName, searchList[i].exerciseType);
                                    (panelController.isPanelClosed)
                                        ? panelController.open()
                                        : panelController.close();
                                  }
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                  panelBuilder: (panelBuilder) => FutureBuilder(
                      future: getDataMapValues(),
                      builder: (_, snapshot){
                        if(snapshot.hasData){
                          List<String> dropDownTitles = snapshot.data!.map((e) => e.toString()).toList();
                          return Container(
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
                                      titleText(text: gym.exercisePanelName),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      subTitleText(text: gym.exercisePanelType),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    color: BackgroundColors.whiteBG,
                                    child: defaultDropDownMenu(
                                        content: dropDownTitles,
                                        hintValue: suggestion,
                                        hintColor: TextColors.blackText,
                                        function: (value) {
                                          gym.dropDownSelect(value, suggestion);
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
                                        // setState(() {
                                        //   switch (suggestion) {
                                        //     case "WarmUp":
                                        //     // warmUp!.add([exerciseName, exerciseType]);
                                        //       break;
                                        //     case "Exercise":
                                        //       exercise.add([exercisePanelName, exercisePanelType]);
                                        //       break;
                                        //     case "Stretches":
                                        //       stretches.add([exercisePanelName, exercisePanelType]);
                                        //       break;
                                        //   }
                                        // });
                                        homeNavigator(context, Navigation());
                                      },
                                      borderRadius: 20,
                                      text: "Add")
                                ],
                              ),
                            ),
                          );
                        }else if(snapshot.hasError){
                          return Center(
                              child: titleText(
                                  text: "Error fetching data ${snapshot.error}"));

                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ));
              }else if (snapshot.hasError) {
                return Center(
                    child: titleText(
                        text: "Error fetching data ${snapshot.error}"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
