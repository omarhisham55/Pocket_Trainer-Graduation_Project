import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:flutter/material.dart';
import '../../data/nutrition_dialog_data.dart';
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
          return Scaffold(
              appBar: changeableAppBar(
                context: context,
                title: "Nutrition Home",
                isRequirementsTaken: isDietTaken,
                replace: QudsPopupButton(
                    tooltip: 'open',
                    items: nutrition.getMenuFoodItems(context),
                    child:
                    const Icon(Icons.more_vert, color: Colors.white, size: 30)),
                bottom: (isDietTaken) ? PreferredSize(
                  preferredSize: const Size.fromHeight(110.0),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: buildDaysOfWeek((date){

                    }),
                  ),
                ) : null,
              ),
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
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => StatefulBuilder(builder: (context, StateSetter setState)=> openDialogAllergy(context, nutrition)),
                              animationType: DialogTransitionType.sizeFade,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(seconds: 1),
                            );
                            // (widget.isGymReqsTaken!) ? openDialogAllergy(context) : showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       backgroundColor: MyColors.dialogBG,
                            //       title: const SubtitleText(text: "Make Program First"),
                            //       actions: [
                            //         Center(
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(bottom: 10.0),
                            //             child: DefaultButton(
                            //               function: (){
                            //                 Navigator.pop(context);
                            //                 openDialogExperience(context);
                            //               },
                            //               child: const SubtitleText(text: "Go"),
                            //             ),
                            //           )
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          text: "Create")
                    ],
                  ),
                ),
              )
                  : const NutritionHome()
          );
        },
      ),
    );
  }
}
