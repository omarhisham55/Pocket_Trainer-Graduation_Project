import 'package:final_packet_trainer/data/gym_dialog_data.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:flutter/material.dart';
import '../../data/nutrition_dialog_data.dart';
import '../../navigation/animationNavigation.dart';
import '../../navigation/cubit/cubit.dart';
import '../../navigation/cubit/states.dart';
import '../../data/nutrition_dialog_data.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import '../gym/gym.dart';
import 'diet_recommended_plan.dart';
import 'nutritionHome.dart';

class Nutrition extends StatelessWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s){},
        builder: (_, s){
          CubitManager nutrition = CubitManager.get(_);
          CubitManager gym = CubitManager.get(_);
          return Scaffold(
              appBar: (isDietTaken == false) ? notificationAppBar(context, "Nutrition") : null,
              backgroundColor: BackgroundColors.background,
              body: (isDietTaken == false) ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 100, right: 40, left: 40),
                  child: Column(
                    children: [
                      Image.asset(
                        FoodImages.emptyNutrition,
                        height: height(context, .4),
                      ),
                      titleText(text: "No schedule yet"),
                      const SizedBox(height: 20),
                      paragraphText(
                        text: "Create your first nutrition plan ... your plan is related to your gym requirements",
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      DefaultButton(
                          function: () {
                            (isExerciseTaken) ?  showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => StatefulBuilder(builder: (context, StateSetter setState)=> openDialogAllergy(context, nutrition)),
                              animationType: DialogTransitionType.sizeFade,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(seconds: 1),
                            ) : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: BackgroundColors.dialogBG,
                                  title: subTitleText(text: "Make Program First"),
                                  actions: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: DefaultButton(
                                          function: (){
                                            Navigator.pop(context);
                                            nutrition.currentIndex = 1;
                                            showAnimatedDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (context) => StatefulBuilder(builder: (context, StateSetter setState)=> openDialogExperience(context, CubitManager.get(_))),
                                              animationType: DialogTransitionType.sizeFade,
                                              curve: Curves.fastOutSlowIn,
                                              duration: const Duration(seconds: 1),
                                            );
                                          },
                                          text: "Go",
                                        ),
                                      )
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          text: "Create")
                    ],
                  ),
                ),
              )
                  : NutritionHome()
          );
        },
      ),
    );
  }
}
