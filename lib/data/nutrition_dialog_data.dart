import 'package:final_packet_trainer/pages/nutrition/diet_recommended_plan.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import '/shared/components/components.dart';
import '/shared/styles/colors.dart';


List<NutritionDialogs> dialogDataN = NutritionDialogs.dialogDataN();

class NutritionDialogs{
  String title;
  List<String> content;

  NutritionDialogs({required this.title, required this.content});

  static List<NutritionDialogs> dialogDataN(){
    List<NutritionDialogs> data = [];
    data.add(NutritionDialogs(
      title: """Are you allergic to any of 
these food""",
      content: ["Eggs", "Vegetables", "Fruits", "Chocolate", "Cheese", "Rice", "Beef", "Chicken", "Pasta", "Milk", "Nuts", "Toast"]));
    data.add(NutritionDialogs(
      title: """Do you have any health 
conditions ?""",
      content: ["lactose Intolerance", "high cholesterol", "PCO", "Insulin resistance", "autoimmune disease", "Hypothyroidism", "Diabetes type 2", "favism (G6PD)", "Hypertension", "Pregnant", "Gastric sleeve"]));
    return data;
  }
}
List<int> dietNumbersListCount = [];

//Nutrition Dialogs
bool isDietTaken = false;
List foodRequirements = [];

List<String> allergySelected = [];
Widget openDialogAllergy(BuildContext context, nutrition)=> defaultDialog(
  context: context,
  title: SizedBox(
    width: width(context, .75),
      child: subTitleText(text: dialogDataN[0].title,maxLines: 2)),
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: MultiSelectContainer(
        itemsPadding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 20, start: 20),
        itemsDecoration: MultiSelectDecorations(
          decoration: BoxDecoration(
              color: BackgroundColors.button,
              borderRadius: BorderRadius.circular(50)
          ),
          selectedDecoration: BoxDecoration(
              color: BackgroundColors.selectedButton,
              borderRadius: BorderRadius.circular(50)
          ),
        ),
        items: [
          MultiSelectCard(value: dialogDataN[0].content[0], label: dialogDataN[0].content[0]),
          MultiSelectCard(value: dialogDataN[0].content[1], label: dialogDataN[0].content[1]),
          MultiSelectCard(value: dialogDataN[0].content[2], label: dialogDataN[0].content[2]),
          MultiSelectCard(value: dialogDataN[0].content[3], label: dialogDataN[0].content[3]),
          MultiSelectCard(value: dialogDataN[0].content[4], label: dialogDataN[0].content[4]),
          MultiSelectCard(value: dialogDataN[0].content[5], label: dialogDataN[0].content[5]),
          MultiSelectCard(value: dialogDataN[0].content[6], label: dialogDataN[0].content[6]),
          MultiSelectCard(value: dialogDataN[0].content[7], label: dialogDataN[0].content[7]),
          MultiSelectCard(value: dialogDataN[0].content[8], label: dialogDataN[0].content[8]),
          MultiSelectCard(value: dialogDataN[0].content[9], label: dialogDataN[0].content[9]),
          MultiSelectCard(value: dialogDataN[0].content[10], label: dialogDataN[0].content[10]),
          MultiSelectCard(value: dialogDataN[0].content[11], label: dialogDataN[0].content[11]),
        ],
        textStyles: const MultiSelectTextStyles(textStyle: TextStyle(color: TextColors.whiteText)),
        onChange: (allSelectedItems, selectedItem) {
          allergySelected = allSelectedItems;
          // print(allergySelected);
        }
    ),
  ),
  quickExit: false,
  setBackIcon: false,
  setNextIcon: true,
  cancelButton: false,
  nextDialog: () {
    foodRequirements.add(allergySelected);
    Navigator.pop(context);
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogHealthConditions(context, nutrition);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  },
);

List<String> healthConditionsSelected = [];
Widget openDialogHealthConditions(BuildContext context, nutrition)=> defaultDialog(
  context: context,
  title: subTitleText(text: dialogDataN[1].title,maxLines: 2),
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        MultiSelectContainer(
            itemsPadding: const EdgeInsetsDirectional.all(10),
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                  color: BackgroundColors.button,
                  borderRadius: BorderRadius.circular(50)
              ),
              selectedDecoration: BoxDecoration(
                  color: BackgroundColors.selectedButton,
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
            items: [
              MultiSelectCard(value: dialogDataN[1].content[0], label: dialogDataN[1].content[0]),
              MultiSelectCard(value: dialogDataN[1].content[1], label: dialogDataN[1].content[1]),
              MultiSelectCard(value: dialogDataN[1].content[2], label: dialogDataN[1].content[2]),
              MultiSelectCard(value: dialogDataN[1].content[3], label: dialogDataN[1].content[3]),
              MultiSelectCard(value: dialogDataN[1].content[4], label: dialogDataN[1].content[4]),
              MultiSelectCard(value: dialogDataN[1].content[5], label: dialogDataN[1].content[5]),
              MultiSelectCard(value: dialogDataN[1].content[6], label: dialogDataN[1].content[6]),
              MultiSelectCard(value: dialogDataN[1].content[7], label: dialogDataN[1].content[7]),
              MultiSelectCard(value: dialogDataN[1].content[8], label: dialogDataN[1].content[8]),
              MultiSelectCard(value: dialogDataN[1].content[9], label: dialogDataN[1].content[9]),
              MultiSelectCard(value: dialogDataN[1].content[10], label: dialogDataN[1].content[10]),
            ],
            textStyles: const MultiSelectTextStyles(textStyle: TextStyle(color: TextColors.whiteText)),
            onChange: (allSelectedItems, selectedItem) {
              healthConditionsSelected = allSelectedItems;
              // print(healthConditionsSelected);
            }
        ),
        const SizedBox(height: 30),
        DefaultButton(
          function: (){
            Navigator.of(context).pop();
            foodRequirements.add(healthConditionsSelected);
            // dietNumbersListCount.add();
            isDietTaken = true;
            nutrition.requirements(isDietTaken);
            pageNavigator(context, RecommendedProgramNutritionInfo());
          },
          borderRadius: 30,
          text: "save"
        )
      ],
    ),
  ),
  quickExit: false,
  setBackIcon: true,
  setNextIcon: false,
  cancelButton: true,
  prevDialog: () {
    Navigator.of(context).pop();
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogAllergy(context, nutrition);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  },
);