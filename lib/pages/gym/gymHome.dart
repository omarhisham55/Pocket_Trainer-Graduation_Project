// ignore_for_file: must_be_immutable

import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/data/gym_dialog_data.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/gym/AddExercise.dart';
import 'package:final_packet_trainer/poseDetectionModel/poseDetection.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/network/local/shared.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flython/flython.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';

class GymHome extends StatelessWidget {
  GymHome({Key? key}) : super(key: key);
  String selectedExerciseType = "select meal time";
  int genrealIndex = 0;
  @override
  Widget build(BuildContext context) {
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
                              text: "This day is off can't add exercises")
                          : {
                              gym.deleteButton(staticBool: false),
                              pageNavigator(context, const AddExercise())
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
                              text: "This day is off no exercises to delete")
                          : gym.deleteButton();
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Exercise info'),
                    onPressed: () {
                      print(daysOfTraining);
                      print(requirements);
                      // Navigator.of(context).push(PremiumAnimation(
                      //     page: GymRecommendedPlan(requirements: requirements, fromHome: true)));
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(6, (index) {
                            final date =
                                DateTime.now().add(Duration(days: index));
                            final isSelected =
                                date.day == gym.selectedDate.day &&
                                    date.month == gym.selectedDate.month &&
                                    date.year == gym.selectedDate.year;
                            final week =
                                allWeekdays[date.weekday - 1].toString();
                            return GestureDetector(
                              onTap: () {
                                print(week);
                                gym.onSelectedDate(date);
                                gym.getWeekday(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? BackgroundColors.blackBG
                                      : BackgroundColors.whiteBG,
                                  borderRadius: BorderRadius.circular(15.0),
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
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
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
                                          padding: const EdgeInsets.all(10.0),
                                          child: SizedBox(
                                            height: height(context, .246),
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
                                      padding: const EdgeInsets.all(5.0),
                                      child: DefaultButton(
                                        function: () async {
                                          print(
                                              'object clicked open camera hooooo');
                                          PoseDetectionModel().model();
                                          // PoseDetectionModel().openCamera();

                                          // await Flython()
                                          //     .initialize(
                                          //         'python',
                                          //         '../../../bodyRecognitionModel//khalid/exercises-tracker-main/exercise.py',
                                          //         false)
                                          //     .then((value) {
                                          //   print('success');
                                          // }).catchError((e) {
                                          //   print('erroe $e');
                                          // });
                                          gym.exercisePanelController.close();
                                        },
                                        text: "Start",
                                        borderRadius: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      body: FutureBuilder(
                          future: getWorkoutPlan(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  final date =
                                      DateTime.now().add(Duration(days: index));
                                  if (date.day == gym.selectedDate.day &&
                                      date.month == gym.selectedDate.month &&
                                      date.year == gym.selectedDate.year) {
                                    return (gym.weekdayOfIndex == "Off Day")
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
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    children: [
                                                      FutureBuilder(
                                                        future:
                                                            getWorkoutPlan(),
                                                        builder: (_, snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            Map<String, dynamic>
                                                                allWorkout =
                                                                snapshot.data!;
                                                            List workout =
                                                                allWorkout[allWorkout
                                                                        .keys
                                                                        .toList()[
                                                                    index]];
                                                            workout = workout
                                                                .where((element) =>
                                                                    element['Type']
                                                                        .contains(
                                                                            'Stretching'))
                                                                .toList();
                                                            // if(daysOfTraining[index] == "Off Day"){
                                                            //   workout[index] = continue;
                                                            // }
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
                                                                          BorderRadius.circular(
                                                                              20),
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
                                                                          context:
                                                                              context,
                                                                          remove:
                                                                              gym.deleteButtonFood,
                                                                          removeFunction:
                                                                              () {
                                                                            gym.deleteWorkouts(exerciseId: workout[i]['exerciseId']).then((value) {
                                                                              toastSuccess(
                                                                                context: context,
                                                                                text: "${workout[i]['name']} has been deleted",
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
                                                                              paragraphText(text: "Sets: "),
                                                                              const SizedBox(width: 15.0),
                                                                              paragraphText(text: "Reps: "),
                                                                            ],
                                                                          ),
                                                                          function:
                                                                              () {
                                                                            print(workout);
                                                                            print(requirements);
                                                                            gym.addExerciseName(
                                                                              workout[i]["exerciseId"],
                                                                              workout[i]["Title"],
                                                                              type: workout[i]["BodyPart"],
                                                                              image: workout[i]['imageUrl'],
                                                                              sets: workout[i]["sets"],
                                                                              reps: workout[i]["repetition"],
                                                                            );
                                                                            (gym.exercisePanelController.isPanelClosed)
                                                                                ? gym.exercisePanelController.open()
                                                                                : gym.exercisePanelController.close();
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
                                                                            border:
                                                                                Border.all(
                                                                              width: 1,
                                                                              color: BackgroundColors.background,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      itemCount:
                                                                          workout
                                                                              .length,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                              child: titleText(
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
                                                          top: 10.0,
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
                                                        builder: (_, snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            Map<String, dynamic>
                                                                allWorkout =
                                                                snapshot.data!;
                                                            List workout =
                                                                allWorkout[allWorkout
                                                                        .keys
                                                                        .toList()[
                                                                    index]];
                                                            workout = workout
                                                                .where((element) =>
                                                                    !element[
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
                                                                              titles[0]),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: BackgroundColors
                                                                          .inkWellBG,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
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
                                                                          context:
                                                                              context,
                                                                          remove:
                                                                              gym.deleteButtonFood,
                                                                          removeFunction:
                                                                              () {
                                                                            gym.deleteWorkouts(exerciseId: workout[i]['exerciseId']).then((value) {
                                                                              toastSuccess(
                                                                                context: context,
                                                                                text: "${workout[i]['name']} has been deleted",
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
                                                                              paragraphText(text: "Sets: "),
                                                                              const SizedBox(width: 15.0),
                                                                              paragraphText(text: "Reps: "),
                                                                            ],
                                                                          ),
                                                                          function:
                                                                              () {
                                                                            print(workout);
                                                                            print(requirements);
                                                                            gym.addExerciseName(
                                                                              workout[i]["exerciseId"],
                                                                              workout[i]["Title"],
                                                                              type: workout[i]["BodyPart"],
                                                                              image: workout[i]['imageUrl'],
                                                                              sets: workout[i]["sets"],
                                                                              reps: workout[i]["repetition"],
                                                                            );
                                                                            (gym.exercisePanelController.isPanelClosed)
                                                                                ? gym.exercisePanelController.open()
                                                                                : gym.exercisePanelController.close();
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
                                                                            border:
                                                                                Border.all(
                                                                              width: 1,
                                                                              color: BackgroundColors.background,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      itemCount:
                                                                          workout
                                                                              .length,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                              child: titleText(
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
                              );
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
                          })),
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
  }
}
