// ignore_for_file: must_be_immutable

import 'package:camera/camera.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/data/gym_dialog_data.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/gym/AddExercise.dart';
import 'package:final_packet_trainer/pages/gym/ExistExercise.dart';
import 'package:final_packet_trainer/pages/information/exerciseDetails.dart';
import 'package:final_packet_trainer/poseDetectionModel/poseDetection.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/network/local/shared.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flython/flython.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../navigation/animationNavigation.dart';
import '../../poseDetectionModel/camera.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import 'gymRecommendedPlan.dart';

class GymHome extends StatelessWidget {
  GymHome({Key? key}) : super(key: key);

  int genrealIndex = 0;
  String selectedExerciseType = "select meal time";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWorkoutPlan(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as Map;
            print('zoma ${data['Day2']}');
            return BlocProvider(
                create: (_) => CubitManager(),
                child: BlocConsumer<CubitManager, MainStateManager>(
                  listener: (_, s) {
                    if (s is DropDownState) {
                      selectedExerciseType = s.selectedValue;
                    }
                  },
                  builder: (_, s) {
                    List<String> titles = ["Warm up", "Exercise", "Stretches"];
                    CubitManager gym = CubitManager.get(_);
                    List<QudsPopupMenuBase> getMenuGym(context) {
                      return [
                        QudsPopupMenuItem(
                            leading: const Icon(Icons.add),
                            title: const Text('Add exercise'),
                            onPressed: () {
                              (gym.weekdayOfIndex == "RestDay")
                                  ? toastWarning(
                                      context: context,
                                      text:
                                          "This day is off can't add exercises")
                                  : {
                                      gym.deleteButton(staticBool: false),
                                      pageNavigator(
                                          context, const AddExercise())
                                    };
                            }),
                        QudsPopupMenuDivider(),
                        QudsPopupMenuItem(
                            leading: const Icon(Icons.delete_outline),
                            title: const Text('Delete exercise'),
                            onPressed: () {
                              (gym.weekdayOfIndex == "RestDay")
                                  ? toastWarning(
                                      context: context,
                                      text:
                                          "This day is off no exercises to delete")
                                  : gym.deleteButton();
                            }),
                        QudsPopupMenuDivider(),
                        QudsPopupMenuItem(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('Exercise info'),
                            onPressed: () {
                              Navigator.of(context).push(PremiumAnimation(
                                  page: const GymRecommendedPlan(
                                      fromHome: true)));
                            }),
                      ];
                    }

                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Scaffold(
                          appBar: changeableAppBar(
                            context: context,
                            title: "Gym Home",
                            isRequirementsTaken: true,
                            replace: QudsPopupButton(
                              tooltip: 'open',
                              items: getMenuGym(context),
                              child: const Icon(Icons.more_vert,
                                  color: Colors.white, size: 30),
                            ),
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(90.0),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List<Widget>.generate(6, (index) {
                                    final date = DateTime.now()
                                        .add(Duration(days: index));
                                    final isSelected = date.day ==
                                            gym.selectedDate.day &&
                                        date.month == gym.selectedDate.month &&
                                        date.year == gym.selectedDate.year;
                                    final week = allWeekdays[date.weekday - 1]
                                        .toString();
                                    return GestureDetector(
                                      onTap: () {
                                        gym.onSelectedDate(date);
                                        gym.getWeekday(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? BackgroundColors.blackBG
                                              : BackgroundColors.whiteBG,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          children: [
                                            paragraphText(
                                              text: week.substring(0, 3),
                                              color: isSelected
                                                  ? TextColors.whiteText
                                                  : TextColors.blackText,
                                            ),
                                            subTitleText(
                                              text: "${date.day}",
                                              color: isSelected
                                                  ? TextColors.whiteText
                                                  : TextColors.blackText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: BackgroundColors.background,
                          body: SlidingUpPanel(
                              controller: gym.exercisePanelController,
                              maxHeight: height(context, .45),
                              minHeight: 0.0,
                              onPanelClosed: () {},
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(30)),
                              panelBuilder: (scrollController) => SafeArea(
                                    child: Container(
                                      width: 400,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width(context, .5),
                                                  child: titleText(
                                                    text: gym.exercisePanelName,
                                                    color: TextColors.blackText,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                subTitleText(
                                                  text:
                                                      "${gym.exercisePanelSets} sets . ${gym.exercisePanelReps} reps",
                                                  color: TextColors.blackText,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SizedBox(
                                                    height:
                                                        height(context, .246),
                                                    child: Image.network(
                                                      gym.exercisePanelImage,
                                                      width: width(context, 1),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: DefaultButton(
                                                function: () async {
                                                  // noNavNavigator(
                                                  //     context, const Camera());
                                                  // PoseDetectionModel()
                                                  //     .getFrames();
                                                  gym.exercisePanelController
                                                      .close();
                                                },
                                                text: "Start",
                                                borderRadius: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              body: RefreshIndicator(
                                onRefresh: () => gym.falseEmit(),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    final date = DateTime.now()
                                        .add(Duration(days: index));
                                    if (date.day == gym.selectedDate.day &&
                                        date.month == gym.selectedDate.month &&
                                        date.year == gym.selectedDate.year) {
                                      return (data['Day${index + 1}'] ==
                                              "dayOff")
                                          ? Column(
                                              children: [
                                                Image.asset(MainImages.restDay),
                                                titleText(text: "Day Off"),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    gym.exercisePanelController
                                                        .close();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      children: [
                                                        FutureBuilder(
                                                          future:
                                                              getWorkoutPlan(),
                                                          builder:
                                                              (_, snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List workout =
                                                                  data[data.keys
                                                                          .toList()[
                                                                      index]];
                                                              workout = workout
                                                                  .where((element) => element[
                                                                          'Type']
                                                                      .contains(
                                                                          'Stretching'))
                                                                  .toList();
                                                              // if(daysOfTraining[index] == "Off Day"){
                                                              //   workout[index] = continue;
                                                              // }
                                                              List<int>
                                                                  stretchDuration =
                                                                  List.generate(
                                                                      workout
                                                                          .length,
                                                                      (value) =>
                                                                          generateStretchDuration());
                                                              void startTimer(
                                                                  BuildContext
                                                                      context,
                                                                  int i) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Timer'),
                                                                      content: Text(
                                                                          'Start timer for ${gym.timeLeft} seconds'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              Text('Start'),
                                                                          onPressed:
                                                                              () {
                                                                            // Navigator.of(context).pop();
                                                                            gym.countdownTimer(stretchDuration[i]);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }

                                                              return Visibility(
                                                                visible: (workout
                                                                        .isEmpty)
                                                                    ? false
                                                                    : true,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const CircleAvatar(
                                                                          radius:
                                                                              5,
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                7),
                                                                        paragraphText(
                                                                            text:
                                                                                titles[2]),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: BackgroundColors
                                                                            .inkWellBG,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child: ListView
                                                                          .separated(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemBuilder:
                                                                            (_, i) {
                                                                          return defaultInkWell(
                                                                            onLongPress: () => pageNavigator(
                                                                                context,
                                                                                ExerciseDetails(
                                                                                  exerciseName: workout[i]['Title'],
                                                                                  exerciseInfo: workout[i]['Desc'],
                                                                                  exerciseImage: workout[i]['imageUrl'],
                                                                                  exerciseType: workout[i]['Type'],
                                                                                  exerciseLevel: workout[i]['Level'],
                                                                                  exerciseEquipment: workout[i]['Equipment'],
                                                                                  exerciseBodyPart: workout[i]['BodyPart'],
                                                                                )),
                                                                            context:
                                                                                context,
                                                                            remove:
                                                                                gym.deleteButtonFood,
                                                                            removeFunction:
                                                                                () {
                                                                              gym.deleteWorkouts(exerciseId: workout[i]['exerciseId']).then((value) {
                                                                                toastSuccess(
                                                                                  context: context,
                                                                                  text: "${workout[i]['Title']} has been deleted",
                                                                                );
                                                                              });
                                                                            },
                                                                            image:
                                                                                workout[i]['imageUrl'],
                                                                            title:
                                                                                workout[i]['Title'] ?? "not found",
                                                                            subtitle: [
                                                                              subTitleText(text: workout[i]["BodyPart"]),
                                                                            ],
                                                                            child:
                                                                                subTitleText(text: "${stretchDuration[i]} sec"),
                                                                            function:
                                                                                () {
                                                                              startTimer(context, i);
                                                                              gym.addExerciseName(
                                                                                workout[i]["exerciseId"],
                                                                                workout[i]["Title"],
                                                                                type: workout[i]["BodyPart"],
                                                                                image: workout[i]['imageUrl'],
                                                                                sets: workout[i]["Sets"],
                                                                                reps: workout[i]["Reps"],
                                                                              );
                                                                              (gym.exercisePanelController.isPanelClosed) ? gym.exercisePanelController.open() : gym.exercisePanelController.close();
                                                                            },
                                                                          );
                                                                        },
                                                                        separatorBuilder:
                                                                            (_, i) =>
                                                                                Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 20),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: BackgroundColors.background,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        itemCount:
                                                                            workout.length,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                child:
                                                                    titleText(
                                                                  text:
                                                                      "Error fetching data ${snapshot.error}",
                                                                ),
                                                              );
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    gym.exercisePanelController
                                                        .close();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 250.0,
                                                            right: 10.0,
                                                            left: 10.0),
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      children: [
                                                        FutureBuilder(
                                                          future:
                                                              getWorkoutPlan(),
                                                          builder:
                                                              (_, snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List workout =
                                                                  data[data.keys
                                                                          .toList()[
                                                                      index]];
                                                              workout = workout
                                                                  .where((element) => !element[
                                                                          'Type']
                                                                      .contains(
                                                                          'Stretching'))
                                                                  .toList();
                                                              return Visibility(
                                                                visible: (workout
                                                                        .isEmpty)
                                                                    ? false
                                                                    : true,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const CircleAvatar(
                                                                          radius:
                                                                              5,
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                7),
                                                                        paragraphText(
                                                                            text:
                                                                                titles[1]),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: BackgroundColors
                                                                            .inkWellBG,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child: ListView
                                                                          .separated(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemBuilder:
                                                                            (_, i) {
                                                                          return defaultInkWell(
                                                                            changeFunction:
                                                                                () {
                                                                              replaceExercise(context: context, oldName: workout[i]['Title'], oldId: workout[i]['exerciseId']);
                                                                            },
                                                                            onLongPress: () => pageNavigator(
                                                                                context,
                                                                                ExerciseDetails(
                                                                                  exerciseName: workout[i]['Title'],
                                                                                  exerciseInfo: workout[i]['Desc'],
                                                                                  exerciseImage: workout[i]['imageUrl'],
                                                                                  exerciseType: workout[i]['Type'],
                                                                                  exerciseLevel: workout[i]['Level'],
                                                                                  exerciseEquipment: workout[i]['Equipment'],
                                                                                  exerciseBodyPart: workout[i]['BodyPart'],
                                                                                )),
                                                                            context:
                                                                                context,
                                                                            remove:
                                                                                gym.deleteButtonFood,
                                                                            removeFunction:
                                                                                () {
                                                                              gym.deleteWorkouts(exerciseId: workout[i]['exerciseId']).then((value) {
                                                                                toastSuccess(
                                                                                  context: context,
                                                                                  text: "${workout[i]['Title']} has been deleted",
                                                                                );
                                                                              });
                                                                            },
                                                                            image:
                                                                                workout[i]['imageUrl'],
                                                                            title:
                                                                                workout[i]['Title'] ?? "not found",
                                                                            subtitle: [
                                                                              subTitleText(text: workout[i]["BodyPart"]),
                                                                            ],
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                paragraphText(text: "Sets: ${workout[i]["Sets"]}"),
                                                                                const SizedBox(width: 15.0),
                                                                                paragraphText(text: "Reps: ${workout[i]["Reps"]}"),
                                                                              ],
                                                                            ),
                                                                            function:
                                                                                () {
                                                                              gym.addExerciseName(
                                                                                workout[i]["exerciseId"],
                                                                                workout[i]["Title"],
                                                                                type: workout[i]["BodyPart"],
                                                                                image: workout[i]['imageUrl'],
                                                                                sets: workout[i]["Sets"],
                                                                                reps: workout[i]["Reps"],
                                                                              );
                                                                              (gym.exercisePanelController.isPanelClosed) ? gym.exercisePanelController.open() : gym.exercisePanelController.close();
                                                                            },
                                                                          );
                                                                        },
                                                                        separatorBuilder:
                                                                            (_, i) =>
                                                                                Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 20),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: BackgroundColors.background,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        itemCount:
                                                                            workout.length,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                child:
                                                                    titleText(
                                                                  text:
                                                                      "Error fetching data ${snapshot.error}",
                                                                ),
                                                              );
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Visibility(
                              visible: (gym.deleteButtonFood) ? true : false,
                              child: DefaultButton(
                                function: () {
                                  gym.deleteButton();
                                },
                                text: "Done",
                                backgroundColor: Colors.red,
                              )),
                        )
                      ],
                    );
                  },
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: titleText(
                text: "Error fetching data ${snapshot.error}",
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
