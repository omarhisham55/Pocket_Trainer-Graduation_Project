import 'package:circle_button/circle_button.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/data/userData.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/gym/AddExercise.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../navigation/animationNavigation.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import '../gym/gym.dart';
import '../nutrition/diet_recommended_plan.dart';

class GymHome extends StatelessWidget {
  GymHome({Key? key}) : super(key: key);
  String selectedMealTime = "select meal time";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
          listener: (_, s) {
            if(s is DropDownState){
              selectedMealTime = s.selectedValue;
            }
          },
          builder: (_, s) {
            List<String> titles = ["Warm up", "Exercise", "Stretches"];
            CubitManager gym = CubitManager.get(_);
            List<QudsPopupMenuBase> getMenuFoodItems(context) {
              return [
                QudsPopupMenuItem(
                    leading: const Icon(Icons.add),
                    title: const Text('Add exercise'),
                    onPressed: () {
                      gym.deleteButton(staticBool: false);
                      pageNavigator(context, const AddExercise());
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Delete exercise'),
                    onPressed: () {
                      gym.deleteButton();
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Exercise info'),
                    onPressed: () {
                      Navigator.of(context).push(PremiumAnimation(
                          page: RecommendedProgramNutritionInfo(fromHome: true)));
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.language_outlined),
                    title: const Text('Change language'),
                    onPressed: () {
                      // showToast('Feedback Pressed!');
                      // print(containerFoodList);
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
                        items: getMenuFoodItems(context),
                        child: const Icon(Icons.more_vert, color: Colors.white, size: 30)),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(110.0),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: buildDaysOfWeek((date){

                        }),
                      ),
                    ),
                  ),
                  backgroundColor: BackgroundColors.background,
                  body: SlidingUpPanel(
                    controller: gym.exercisePanelController,
                    maxHeight: height(context, .4),
                    minHeight: 0.0,
                    onPanelClosed: (){},
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    //SlideUp panel for show food list when blue button appears
                    panelBuilder: (scrollController) => SafeArea(
                      child: Container(
                        width: 400,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleText(
                                      text: "titles[indexA]",
                                      color: TextColors.blackText),
                                  const SizedBox(height: 20),
                                  subTitleText(
                                      text: "X sets . X reps",
                                      color: TextColors.blackText),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      GymImages.gymBg,
                                      width: width(context, 1),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: DefaultButton(
                                  function: () {
                                    gym.exercisePanelController.close();
                                  },
                                  text: "Start",
                                  borderRadius: 30,
                                  width: MediaQuery.of(context).size.width * .4,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: InkWell(
                      onTap: (){gym.exercisePanelController.close();},
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 250.0, top: 10.0, right: 10.0, left: 10.0),
                          child: ListView(
                            children: [
                              FutureBuilder(
                                  future: getWorkoutPlan(),
                                  builder: (_, snapshot){
                                    print('from gym home ${snapshot.data}');
                                    if(snapshot.hasData){
                                      List workout = snapshot.data!;
                                      return Visibility(
                                          visible: (workout.isEmpty) ? false : true,
                                          child:  Column(
                                            children: [
                                              //green circle, title
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: Colors.green,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  paragraphText(text: titles[0])
                                                ],
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: BackgroundColors.inkWellBG,
                                                      borderRadius:
                                                      BorderRadius.circular(20)),
                                                  child: ListView.separated(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (_, i) {
                                                        return defaultInkWell(
                                                            remove: gym.deleteButtonFood,
                                                            removeFunction: (){
                                                              gym.deleteWorkouts(exerciseId: workout[i]['exerciseId']).then((value) {
                                                                toastSuccess(context: context, text: "${workout[i]['name']} has been deleted");
                                                              });
                                                            },
                                                            image: workout[i]['imageUrl'] ?? "not found",
                                                            title: workout[i]['name'] ?? "not found",
                                                            subtitle: subTitleText(text: workout[i]["bodyPart"]),
                                                            child: Row(
                                                              children: [
                                                                paragraphText(text: "Sets: ${workout[i]['sets'] ?? "not found"}"),
                                                                const SizedBox(width: 15.0),
                                                                paragraphText(text: "Reps: ${workout[i]['repetition'] ?? "not found"}"),
                                                              ],
                                                            ),
                                                            function: () {
                                                              (gym.exercisePanelController.isPanelClosed) ? gym.exercisePanelController.open()
                                                                  : gym.exercisePanelController.close();
                                                            }
                                                          );
                                                      },
                                                      separatorBuilder: (_, i) => Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: BackgroundColors
                                                                      .background)),
                                                        ),
                                                      ),
                                                      itemCount: workout.length))
                                            ],
                                          ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: titleText(
                                              text: "Error fetching data ${snapshot.error}"));
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  }
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Visibility(
                      visible: (gym.deleteButtonFood) ? true : false,
                      child: DefaultButton(
                        function: (){gym.deleteButton();},
                        text: "Done",
                        backgroundColor: Colors.red,
                      )
                  ),
                )
              ],
            );
          },
        )
    );
  }
}