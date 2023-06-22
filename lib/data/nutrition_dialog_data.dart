import 'package:final_packet_trainer/pages/nutrition/diet_recommended_plan.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import '/shared/components/components.dart';
import '/shared/styles/colors.dart';

List<NutritionDialogs> dialogDataN = NutritionDialogs.dialogDataN();

class NutritionDialogs {
  String title;
  List<String> content;

  NutritionDialogs({required this.title, required this.content});

  static List<NutritionDialogs> dialogDataN() {
    List<NutritionDialogs> data = [];
    data.add(NutritionDialogs(
        title: """How old are you""", content: [ageController.text]));
    data.add(
        NutritionDialogs(title: """Are you vegan?""", content: ['yes', 'no']));
    data.add(NutritionDialogs(
        title: """What is your goal?""",
        content: ['Healthy', 'Weight Loss', 'Weight Gain']));
    return data;
  }
}

List<int> dietNumbersListCount = [];

//Nutrition Dialogs
bool isDietTaken = false;
List foodRequirements = ['', '', ''];

TextEditingController ageController = TextEditingController();
Widget openDialogAge(BuildContext context, nutrition) => defaultDialog(
      context: context,
      title: SizedBox(
          width: width(context, .75),
          child: subTitleText(text: dialogDataN[0].title, maxLines: 2)),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: defaultTextFormField(
              controller: ageController,
              hint: 'age',
              textInputType: TextInputType.number)),
      quickExit: false,
      setBackIcon: false,
      setNextIcon: true,
      cancelButton: false,
      nextDialog: () {
        int age = int.parse(ageController.text);
        print(foodRequirements);
        if (age < 12) {
          const snackBar = SnackBar(
            content: Text(
              "your age isn't compatible",
              style: TextStyle(fontSize: 14),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          foodRequirements[0] = (age.toString());
          Navigator.pop(context);
          showAnimatedDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                StatefulBuilder(builder: (context, StateSetter setState) {
              return openDialogIsVegan(context, nutrition);
            }),
            animationType: DialogTransitionType.sizeFade,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
        }
      },
    );

bool isVegan = false;
Widget openDialogIsVegan(BuildContext context, nutrition) =>
    StatefulBuilder(builder: (context, setState) {
      return defaultDialog(
        context: context,
        title: subTitleText(text: dialogDataN[1].title, maxLines: 2),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isVegan = false;
                        print(isVegan);
                      });
                    },
                    child: Container(
                      width: width(context, 1),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: (!isVegan)
                                ? BackgroundColors.selectedButton
                                : BackgroundColors.whiteBG,
                            width: (!isVegan) ? 3 : 1,
                          )),
                      child: subTitleText(text: dialogDataN[1].content[0]),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isVegan = true;
                        print(isVegan);
                      });
                    },
                    child: Container(
                      width: width(context, 1),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: (isVegan)
                                ? BackgroundColors.selectedButton
                                : BackgroundColors.whiteBG,
                            width: (isVegan) ? 3 : 1,
                          )),
                      child: subTitleText(text: dialogDataN[1].content[1]),
                    ),
                  )),
            ],
          ),
        ),
        quickExit: false,
        setBackIcon: true,
        setNextIcon: true,
        nextDialog: () {
          foodRequirements[1] = (isVegan) ? "1" : "0";
          print(foodRequirements);
          Navigator.of(context).pop();
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StatefulBuilder(builder: (context, StateSetter setState) {
              return openDialogGoalN(context, nutrition);
            }),
            animationType: DialogTransitionType.sizeFade,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
        },
        cancelButton: true,
        prevDialog: () {
          Navigator.of(context).pop();
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StatefulBuilder(builder: (context, StateSetter setState) {
              return openDialogAge(context, nutrition);
            }),
            animationType: DialogTransitionType.sizeFade,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
        },
      );
    });

final List<bool> selectedButtonGoalN = List.generate(3, (i) => false);
String goalN = '';
Widget openDialogGoalN(BuildContext context, nutrition) => StatefulBuilder(
    builder: (context, StateSetter setState) => defaultDialog(
          context: context,
          title: subTitleText(text: dialogDataN[2].title, maxLines: 2),
          body: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MaterialButton(
                          color: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              selectedButtonGoalN.replaceRange(
                                  0, selectedButtonGoalN.length, [
                                for (int i = 0;
                                    i < selectedButtonGoalN.length;
                                    i++)
                                  false
                              ]);
                              selectedButtonGoalN[index] = true;
                              goalN = dialogDataN[2].content[index];
                            });
                          },
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                width: (selectedButtonGoalN[index]) ? 3 : 1,
                                color: (selectedButtonGoalN[index])
                                    ? BackgroundColors.selectedButton
                                    : BackgroundColors.whiteBG,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: paragraphText(
                                      text: dialogDataN[2].content[index],
                                      textAlign: TextAlign.start),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  itemCount: dialogDataN[2].content.length),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: DefaultButton(
                    function: () {
                      foodRequirements[2] = goalN;
                      print(foodRequirements);
                      nutrition
                          .createNutritionPlan(context, foodRequirements)
                          .then((value) {
                        isDietTaken = true;
                        Navigator.of(context).pop();
                        toastSuccess(context: context, text: value['message']);
                      }).catchError((error) {
                        toastError(context: context, text: error);
                      });
                    },
                    text: "Save"),
              )
            ],
          ),
          quickExit: true,
          setBackIcon: true,
          prevDialog: () {
            Navigator.of(context).pop();
            showAnimatedDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) =>
                  StatefulBuilder(builder: (context, StateSetter setState) {
                return openDialogIsVegan(context, nutrition);
              }),
              animationType: DialogTransitionType.sizeFade,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 1),
            );
          },
          setNextIcon: false,
          cancelButton: false,
        ));
