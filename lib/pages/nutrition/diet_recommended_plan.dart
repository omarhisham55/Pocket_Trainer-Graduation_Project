import 'package:final_packet_trainer/data/nutrition_dialog_data.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../navigation/cubit/states.dart';
import '/shared/components/components.dart';
import '/shared/styles/colors.dart';
import '/shared/styles/images.dart';

class RecommendedProgramNutritionInfo extends StatelessWidget {
  final String? calories;
  final String? protein;
  final String? carbs;
  final String? fats;
  final String? goal;
  final String? general;
  bool? fromHome = false;

  RecommendedProgramNutritionInfo(
      {Key? key,
      this.calories,
      this.protein,
      this.carbs,
      this.fats,
      this.goal,
      this.general,
      this.fromHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {},
        builder: (_, s) {
          CubitManager nutrition = CubitManager.get(_);
          var caloriesData = calories ?? "not defined";
          var proteinData = protein ?? "not defined";
          var carbsData = carbs ?? "not defined";
          var fatsData = fats ?? "not defined";
          var goalData = goal ?? "not defined";
          var generalData = general ?? "not defined";
          var isFromHome = fromHome ?? false;
          return WillPopScope(
            onWillPop: () async {
              return false; // Prevent back navigation
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: const Icon(Icons.arrow_back_ios,
                      color: Colors.transparent),
                  title: Center(child: titleText(text: 'Diet information')),
                  actions: [
                    Visibility(
                        visible: (isFromHome) ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: TextColors.whiteText, size: 30),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ))
                  ]),
              body: Stack(
                children: [
                  Image.asset(FoodImages.nutritionBg,
                      width: double.infinity, fit: BoxFit.fitWidth),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 200),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText(
                                text: "Gain Diet",
                                color: TextColors.blackText,
                                fontWeight: FontWeight.w700),
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //calories
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Calories: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text: "$caloriesData Kcal",
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //protein, carbs and fats
                                    Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            paragraphText(
                                              text: "Protein:  ",
                                              color: TextColors.blackText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            paragraphText(
                                              text: "$proteinData g",
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            paragraphText(
                                              text: "Carbs:  ",
                                              color: TextColors.blackText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            paragraphText(
                                              text: "$carbsData g",
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            paragraphText(
                                              text: "Fats:  ",
                                              color: TextColors.blackText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            paragraphText(
                                              text: "$fatsData g",
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //goal
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Goal: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text: goalData,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //notes
                                    Wrap(
                                      children: [
                                        paragraphText(
                                          text:
                                              "General instructions for the diet: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: paragraphText(
                                              text: generalData,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700,
                                              maxLines: 17,
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Set as default button
                  (fromHome ?? false)
                      ? Positioned(
                          bottom: 50,
                          left: width(context, .25),
                          child: DefaultButton(
                              function: () {
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => StatefulBuilder(
                                      builder: (context,
                                              StateSetter setState) =>
                                          openDialogAge(
                                              context, CubitManager.get(_))),
                                  animationType: DialogTransitionType.sizeFade,
                                  curve: Curves.fastOutSlowIn,
                                  duration: const Duration(seconds: 1),
                                );
                              },
                              width: width(context, .5),
                              borderRadius: 30,
                              text: 'Change plan'),
                        )
                      : Positioned(
                          bottom: 50,
                          left: width(context, .25),
                          child: DefaultButton(
                              function: () {
                                Navigator.pop(context);
                              },
                              width: width(context, .5),
                              borderRadius: 30,
                              text: 'Set as default'),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
