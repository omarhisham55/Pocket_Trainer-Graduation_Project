import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';

List<GymDialogs> dialogDataG = GymDialogs.dialogDataG();

//Gym data
class GymDialogs {
  List<String> title;
  List<String>? subtitle;
  List<String> content;

  GymDialogs({required this.title, this.subtitle, required this.content});

  static List<GymDialogs> dialogDataG() {
    List<GymDialogs> data = [];

    data.add(GymDialogs(title: [
      "    Experience"
    ], subtitle: [
      "Beginner",
      "Intermediate",
      "Advanced"
    ], content: [
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ]));
    data.add(GymDialogs(title: [
      "Goal"
    ], subtitle: [
      "Strength",
      "Muscle size",
      "Cardio"
    ], content: [
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ]));
    data.add(GymDialogs(
        title: ["Choose your training days"],
        content: ["S", "S", "M", "T", "W", "T", "F"]));
    data.add(GymDialogs(title: [
      "Workout tools"
    ], subtitle: [
      "Select your equipment workout tools"
    ], content: [
      "Barbell",
      "Dumbbells",
      "Machines",
      "Body weight",
      "Cables"
    ]));
    data.add(GymDialogs(
        title: ["Add your weight and height"],
        content: [addHeight.text, addWeight.text]));
    data.add(GymDialogs(title: [
      "Do you have any injuries ?"
    ], content: [
      "Shoulder joint osteoarthritis",
      "rotator cuff tendinitis",
      "Recurrent shoulder dislocation",
      "Ankle sprain",
      "Biceps tendinitis",
      "Calf muscle tear",
      "Anterior Cruciate Ligament tear",
      "Tennis elbow",
      "Meniscus injury",
      "Lower back pains",
      "Knee osteoarthritis"
    ]));
    data.add(GymDialogs(
        title: ["Body measurements"],
        subtitle: ["Inbody"],
        content: ['Body fat percent', 'Muscle mass', 'Fat mass', 'BMI']));
    return data;
  }
}

void popAndShowNext({required BuildContext context, required dialog, required cubit}){
  Navigator.pop(context);
  showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        StatefulBuilder(builder: (context, StateSetter setState) {
          return dialog(context, cubit);
        }),
    animationType: DialogTransitionType.sizeFade,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(seconds: 1),
  );
}

bool isExerciseTaken = false;
List requirements = ["", "", "", [], [], []];

final List<bool> selectedButtonExp = List.generate(3, (i) => false);
Widget openDialogExperience(BuildContext context, gym) => StatefulBuilder(
    builder: (context, StateSetter setState) => defaultDialog(
          context: context,
          title: subTitleText(text: dialogDataG[0].title[0], maxLines: 2),
          body: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: dialogButton(
                      buttonTitle: dialogDataG[0].subtitle![index],
                      buttonContent: dialogDataG[0].content[index],
                      borderWidth: (selectedButtonExp[index]) ? 3 : 1,
                      borderColor: (selectedButtonExp[index])
                          ? BackgroundColors.selectedButton
                          : BackgroundColors.whiteBG,
                      function: () {
                        setState(() {
                          selectedButtonExp.replaceRange(
                              0, selectedButtonExp.length, [
                            for (int i = 0; i < selectedButtonExp.length; i++)
                              false
                          ]);
                          selectedButtonExp[index] = true;
                        });
                      },
                    ),
                  ),
              itemCount: dialogDataG[0].subtitle!.length),
          nextDialog: () {
            setState(() {
              switch (selectedButtonExp.indexOf(true)) {
                case 0:
                  requirements.removeAt(0);
                  requirements.insert(0, dialogDataG[0].subtitle![0]);
                  popAndShowNext(context: context, dialog: openDialogGoal, cubit: gym);
                  break;
                case 1:
                  requirements.removeAt(0);
                  requirements.insert(0, dialogDataG[0].subtitle![1]);
                  popAndShowNext(context: context, dialog: openDialogGoal, cubit: gym);
                  break;
                case 2:
                  requirements.removeAt(0);
                  requirements.insert(0, dialogDataG[0].subtitle![2]);
                  popAndShowNext(context: context, dialog: openDialogGoal, cubit: gym);
                  break;
                default:
                  const snackBar = SnackBar(
                    content: Text(
                      "You must choose",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  break;
              }
              print("requirements from experience $requirements");
            });
          },
          quickExit: true,
          setBackIcon: false,
          setNextIcon: true,
          cancelButton: false,
        )
);

final List<bool> selectedButtonG = List.generate(3, (i) => false);
Widget openDialogGoal(BuildContext context, gym) => StatefulBuilder(
    builder: (context, StateSetter setState) => defaultDialog(
        context: context,
        title: subTitleText(text: dialogDataG[1].title[0], maxLines: 2),
        body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: dialogButton(
                    buttonTitle: dialogDataG[1].subtitle![index],
                    buttonContent: dialogDataG[1].content[index],
                    borderWidth: (selectedButtonG[index]) ? 3 : 1,
                    borderColor: (selectedButtonG[index])
                        ? BackgroundColors.selectedButton
                        : BackgroundColors.whiteBG,
                    function: () {
                      setState(() {
                        //three button select one
                        selectedButtonG.replaceRange(
                            0, selectedButtonG.length, [
                          for (int i = 0; i < selectedButtonG.length; i++) false
                        ]);
                        selectedButtonG[index] = true;
                      });
                    },
                  ),
                ),
            itemCount: dialogDataG[1].subtitle!.length),
        quickExit: false,
        setBackIcon: true,
        setNextIcon: true,
        cancelButton: true,
        prevDialog: () {
          requirements[0] = "";
          print(requirements);
          popAndShowNext(context: context, dialog: openDialogExperience, cubit: gym);
        },
        nextDialog: () {
          setState(() {
            switch (selectedButtonG.indexOf(true)) {
              case 0:
                requirements.removeAt(1);
                requirements.insert(1, dialogDataG[1].subtitle![0]);
                popAndShowNext(context: context, dialog: openDialogDate, cubit: gym);
                break;
              case 1:
                requirements.removeAt(1);
                requirements.insert(1, dialogDataG[1].subtitle![1]);
                popAndShowNext(context: context, dialog: openDialogDate, cubit: gym);
                break;
              case 2:
                requirements.removeAt(1);
                requirements.insert(1, dialogDataG[1].subtitle![2]);
                popAndShowNext(context: context, dialog: openDialogDate, cubit: gym);
                break;
              default:
                const snackBar = SnackBar(
                  content: Text(
                    "You must choose",
                    style: TextStyle(fontSize: 14),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
            }
            print("requirements from goal $requirements");
          });
        })
);

List selectedDays = [];
List daysOfTraining = [];
List<MultiSelectCard<Object?>> weekdays = [
  MultiSelectCard(value: 'Saturday', label: dialogDataG[2].content[0]),
  MultiSelectCard(value: 'Sunday', label: dialogDataG[2].content[1]),
  MultiSelectCard(value: 'Monday', label: dialogDataG[2].content[2]),
  MultiSelectCard(value: 'Tuesday', label: dialogDataG[2].content[3]),
  MultiSelectCard(value: 'Wednesday', label: dialogDataG[2].content[4]),
  MultiSelectCard(value: 'Thursday', label: dialogDataG[2].content[5]),
  MultiSelectCard(value: 'Friday', label: dialogDataG[2].content[6]),
];
var allWeekdays = weekdays.map((item) => item.value).toList();

Widget openDialogDate(BuildContext context, gym) => defaultDialog(
      context: context,
      title: subTitleText(text: dialogDataG[2].title[0], maxLines: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: MultiSelectContainer(
            itemsPadding: const EdgeInsetsDirectional.all(12),
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                  color: BackgroundColors.button,
                  borderRadius: BorderRadius.circular(50)),
              selectedDecoration: BoxDecoration(
                  color: BackgroundColors.selectedButton,
                  borderRadius: BorderRadius.circular(50)),
            ),
            items: weekdays,
            onChange: (allSelectedItems, selectedItem) {
              selectedDays = allSelectedItems;
              print(allWeekdays);
              print(selectedDays);
            }),
      ),
      quickExit: false,
      setBackIcon: true,
      setNextIcon: true,
      cancelButton: true,
      prevDialog: () {
        requirements[1] = "";
        popAndShowNext(context: context, dialog: openDialogGoal, cubit: gym);
      },
      nextDialog: () {
        if (selectedDays.length < 3) {
          const snackBar = SnackBar(
            content: Text(
              "Training days must be more than 2 days",
              style: TextStyle(fontSize: 14),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          for (var day in allWeekdays) {
            if (selectedDays.contains(day)) {
              daysOfTraining.add('Working Day');
            } else {
              daysOfTraining.add('Off Day');
            }
          }
          requirements.removeAt(2);
          requirements.insert(2, daysOfTraining);
          print("requirements from date $requirements");
          popAndShowNext(context: context, dialog: openDialogWorkoutTools, cubit: gym);
        }
      },
    );

List selectedTools = [];
List<MultiSelectCard<Object?>> tools = [
  MultiSelectCard(
      value: dialogDataG[3].content[0],
      label: dialogDataG[3].content[0]),
  MultiSelectCard(
      value: dialogDataG[3].content[1],
      label: dialogDataG[3].content[1]),
  MultiSelectCard(
      value: dialogDataG[3].content[2],
      label: dialogDataG[3].content[2]),
  MultiSelectCard(
      value: dialogDataG[3].content[3],
      label: dialogDataG[3].content[3]),
  MultiSelectCard(
      value: dialogDataG[3].content[4],
      label: dialogDataG[3].content[4]),
];

Widget openDialogWorkoutTools(BuildContext context, gym) => defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[3].title[0], maxLines: 2),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(dialogDataG[3].subtitle![0],
              style:
                  const TextStyle(color: TextColors.whiteText, fontSize: 18)),
        ),
        MultiSelectContainer(
            itemsPadding: const EdgeInsetsDirectional.all(10),
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                  color: BackgroundColors.button,
                  borderRadius: BorderRadius.circular(50)),
              selectedDecoration: BoxDecoration(
                  color: BackgroundColors.selectedButton,
                  borderRadius: BorderRadius.circular(50)),
            ),
            items: tools,
            onChange: (allSelectedItems, selectedItem) {
              selectedTools = allSelectedItems;
            }),
      ],
    ),
    quickExit: false,
    setBackIcon: true,
    setNextIcon: true,
    cancelButton: true,
    prevDialog: () {
      requirements[2] = [];
      daysOfTraining = [];
      print(requirements);
      popAndShowNext(context: context, dialog: openDialogDate, cubit: gym);
    },
    nextDialog: () {
      if (selectedTools.isEmpty) {
        const snackBar = SnackBar(
          content: Text(
            "You must choose",
            style: TextStyle(fontSize: 14),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        requirements.removeAt(3);
        requirements.insert(3, selectedTools);
        print("requirements from tools $requirements");
        popAndShowNext(context: context, dialog: openDialogHW, cubit: gym);
      }
    });

TextEditingController addHeight = TextEditingController();
TextEditingController addWeight = TextEditingController();
Widget openDialogHW(BuildContext context, gym) => defaultDialog(
      context: context,
      title: subTitleText(text: dialogDataG[4].title[0], maxLines: 2),
      body: Column(
        children: [
          SizedBox(
            width: width(context, .4),
            child: defaultTextFormField(
              controller: addHeight,
              textInputType: TextInputType.number,
              hint: "height",
              textAlign: TextAlign.start,
              border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: BackgroundColors.whiteBG)),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: BackgroundColors.whiteBG)),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: width(context, .4),
            child: defaultTextFormField(
              controller: addWeight,
              textInputType: TextInputType.number,
              hint: "weight",
              textAlign: TextAlign.start,
              border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: BackgroundColors.whiteBG)),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: BackgroundColors.whiteBG)),
            ),
          ),
        ],
      ),
      quickExit: false,
      setBackIcon: true,
      setNextIcon: true,
      cancelButton: true,
      prevDialog: () {
        requirements[3] = [];
        selectedTools = [];
        popAndShowNext(context: context, dialog: openDialogWorkoutTools, cubit: gym);
      },
      nextDialog: () {
        if(addHeight.text.isEmpty || addWeight.text.isEmpty){
          const snackBar = SnackBar(
            content: Text(
              "add height and weight",
              style: TextStyle(fontSize: 14),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else{
          requirements.removeAt(4);
          requirements.insert(4, [addHeight.text, addWeight.text]);
          print("requirements from H&W $requirements");
          popAndShowNext(context: context, dialog: openDialogInjuries, cubit: gym);
        }
      },
    );

List<String> selectedInjuries = [];
Widget openDialogInjuries(BuildContext context, gym) => defaultDialog(
      context: context,
      title: subTitleText(text: dialogDataG[5].title[0], maxLines: 2),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MultiSelectContainer(
                itemsPadding: const EdgeInsetsDirectional.all(10),
                itemsDecoration: MultiSelectDecorations(
                  decoration: BoxDecoration(
                      color: BackgroundColors.button,
                      borderRadius: BorderRadius.circular(50)),
                  selectedDecoration: BoxDecoration(
                      color: BackgroundColors.selectedButton,
                      borderRadius: BorderRadius.circular(50)),
                ),
                items: [
                  MultiSelectCard(
                      value: dialogDataG[5].content[0],
                      label: dialogDataG[5].content[0]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[1],
                      label: dialogDataG[5].content[1]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[2],
                      label: dialogDataG[5].content[2]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[3],
                      label: dialogDataG[5].content[3]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[4],
                      label: dialogDataG[5].content[4]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[5],
                      label: dialogDataG[5].content[5]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[6],
                      label: dialogDataG[5].content[6]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[7],
                      label: dialogDataG[5].content[7]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[8],
                      label: dialogDataG[5].content[8]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[9],
                      label: dialogDataG[5].content[9]),
                  MultiSelectCard(
                      value: dialogDataG[5].content[10],
                      label: dialogDataG[5].content[10]),
                ],
                onChange: (allSelectedItems, selectedItem) {
                  selectedInjuries = allSelectedItems;
                }),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: DefaultButton(
                function: () {
                  requirements.removeAt(5);
                  requirements.insert(5, selectedInjuries);
                  print("requirements from injuries $requirements");
                  isExerciseTaken = true;
                  gym.requirements(isExerciseTaken);
                  Navigator.pop(context);
                },
                borderRadius: 30,
                text: "save",
              ))
        ],
      ),
      quickExit: false,
      setBackIcon: true,
      setNextIcon: false,
      cancelButton: true,
      prevDialog: () {
        popAndShowNext(context: context, dialog: openDialogHW, cubit: gym);
      },
    );
