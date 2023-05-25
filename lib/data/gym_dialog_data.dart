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

    data.add(GymDialogs(title: ["    Experience"],
        subtitle: ["Beginner", "Intermediate", "Advanced"],
        content: [
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        ]));
    data.add(GymDialogs(title: ["Goal"],
        subtitle: ["Strength", "Muscle size", "Cardio"],
        content: [
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        ]));
    data.add(GymDialogs(title: ["Choose your training days"],
        content: ["S", "S", "M", "T", "W", "T", "F"]));
    data.add(GymDialogs(title: ["Workout tools"],
        subtitle: ["Select your equipment workout tools"],
        content: [
          "Barbell",
          "Dumbbells",
          "Machines",
          "Body weight",
          "Cables"
        ]));
    data.add(GymDialogs(
        title: ["Add your weight and height"], content: [addHeight.text, addWeight.text]));
    data.add(GymDialogs(title: ["Do you have any injuries ?"],
        content: [
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
    data.add(GymDialogs(title: ["Body measurements"],
        subtitle: ["Inbody"],
        content: ['Body fat percent', 'Muscle mass', 'Fat mass', 'BMI']));
    return data;
  }
}

bool isExerciseTaken = true;
List requirements = ["","","",[],[],[],[]];

void buttonGoalSelected(int index, int subTitle){
  switch (subTitle){
    case 0:
      requirements.removeAt(1);
      requirements.insert(index, dialogDataG[1].subtitle![0]);
      break;
    case 1:
      requirements.removeAt(1);
      requirements.insert(index, dialogDataG[1].subtitle![1]);
      break;
    case 2:
      requirements.removeAt(1);
      requirements.insert(index, dialogDataG[1].subtitle![2]);
      break;
  }

}

final List<bool> selectedButtonExp = List.generate(3, (i) => false);
bool eChosen = false;
Widget openDialogExperience(BuildContext context, gym) => StatefulBuilder(builder: (context, StateSetter setState)=> defaultDialog(
  context: context,
  title: subTitleText(text: dialogDataG[0].title[0],maxLines: 2),
  body: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: dialogButton(
            buttonTitle: dialogDataG[0].subtitle![index],
            buttonContent: dialogDataG[0].content[index],
            borderWidth: (selectedButtonExp[index]) ? 3 : 1,
            borderColor: (selectedButtonExp[index]) ? BackgroundColors.selectedButton : BackgroundColors.whiteBG,
            function: (){
              setState(() {
                selectedButtonExp.replaceRange(0, selectedButtonExp.length,
                    [for(int i = 0; i < selectedButtonExp.length; i++)false]);
                selectedButtonExp[index]=true;
              });
            },
        ),
      ),
      itemCount: dialogDataG[0].subtitle!.length),
  nextDialog: () {
    setState(() {
      switch (selectedButtonExp.indexOf(true)){
        case 0:
          eChosen = false;
          requirements.removeAt(0);
          requirements.insert(0, dialogDataG[0].subtitle![0]);
          break;
        case 1:
          eChosen = false;
          requirements.removeAt(0);
          requirements.insert(0, dialogDataG[0].subtitle![1]);
          break;
        case 2:
          eChosen = false;
          requirements.removeAt(0);
          requirements.insert(0, dialogDataG[0].subtitle![2]);
          break;
        default:
          eChosen = true;
          const snackBar = SnackBar(
            content: Text(
              "You must choose",
              style: TextStyle(fontSize: 14),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
      if(!eChosen){
        Navigator.pop(context);
        showAnimatedDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
            return openDialogGoal(context, gym);
          }),
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
      }
    });
  },
  quickExit: true,
  setBackIcon: false,
  setNextIcon: true,
  cancelButton: false,
));
final List<bool> selectedButtonG = List.generate(3, (i) => false);
bool gChosen = false;
Widget openDialogGoal(BuildContext context, gym) => StatefulBuilder(builder: (context, StateSetter setState)=> defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[1].title[0],maxLines: 2),
    body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: dialogButton(
            buttonTitle: dialogDataG[1].subtitle![index],
            buttonContent: dialogDataG[1].content[index],
            borderWidth: (selectedButtonG[index]) ? 3 : 1,
            borderColor: (selectedButtonG[index]) ? BackgroundColors.selectedButton : BackgroundColors.whiteBG,
            function: (){
              setState(() {
                //three button select one
                selectedButtonG.replaceRange(0, selectedButtonG.length,
                    [for(int i = 0; i < selectedButtonG.length; i++)false]);
                selectedButtonG[index]=true;
              });
            },
          ),
        ),
        itemCount: dialogDataG[1].subtitle!.length
    ),
    quickExit: false,
    setBackIcon: true,
    setNextIcon: true,
    cancelButton: true,
    prevDialog: () {
      Navigator.of(context).pop();
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
          return openDialogExperience(context, gym);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    },
    nextDialog: () {
      setState((){
        switch(selectedButtonG.indexOf(true)){
          case 0:
            gChosen = false;
            buttonGoalSelected(1, 0);
            break;
          case 1:
            gChosen = false;
            buttonGoalSelected(1, 1);
            break;
          case 2:
            gChosen = false;
            buttonGoalSelected(1, 2);
            break;
          default:
            gChosen = true;
            const snackBar = SnackBar(
              content: Text(
                "You must choose",
                style: TextStyle(fontSize: 14),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
        }
        if(!gChosen){
          Navigator.pop(context);
          showAnimatedDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
              return openDialogDate(context, gym);
            }),
            animationType: DialogTransitionType.sizeFade,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
        }
      });
    }
));
List<String> selectedDays = [];
Widget openDialogDate(BuildContext context, gym) => defaultDialog(
  context: context,
  title: subTitleText(text: dialogDataG[2].title[0],maxLines: 2),
  body: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: MultiSelectContainer(
        itemsPadding: const EdgeInsetsDirectional.all(12),
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
          MultiSelectCard(value: 'Saturday', label: dialogDataG[2].content[0]),
          MultiSelectCard(value: 'Sunday', label: dialogDataG[2].content[1]),
          MultiSelectCard(value: 'Monday', label: dialogDataG[2].content[2]),
          MultiSelectCard(value: 'Tuesday', label: dialogDataG[2].content[3]),
          MultiSelectCard(value: 'Wednesday', label: dialogDataG[2].content[4]),
          MultiSelectCard(value: 'Thursday', label: dialogDataG[2].content[5]),
          MultiSelectCard(value: 'Friday', label: dialogDataG[2].content[6]),
        ], onChange: (allSelectedItems, selectedItem) {
      selectedDays = allSelectedItems;
    }
    ),
  ),
  quickExit: false,
  setBackIcon: true,
  setNextIcon: true,
  cancelButton: true,
  prevDialog: () {
    Navigator.of(context).pop();
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogGoal(context, gym);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  },
  nextDialog: () {
    if(selectedDays.length < 3){
      const snackBar = SnackBar(
        content: Text(
          "Training days must be more than 2 days",
          style: TextStyle(fontSize: 14),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      requirements.removeAt(2);
      requirements.insert(2, selectedDays.length.toString());
      Navigator.pop(context);
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
          return openDialogWorkoutTools(context, gym);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    }
  },
);

List<String> selectedTools = [];
Widget openDialogWorkoutTools(BuildContext context, gym) => defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[3].title[0],maxLines: 2),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(dialogDataG[3].subtitle![0], style: const TextStyle(color: TextColors.whiteText,fontSize: 18)),
        ),
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
              MultiSelectCard(value: dialogDataG[3].content[0], label: dialogDataG[3].content[0]),
              MultiSelectCard(value: dialogDataG[3].content[1], label: dialogDataG[3].content[1]),
              MultiSelectCard(value: dialogDataG[3].content[2], label: dialogDataG[3].content[2]),
              MultiSelectCard(value: dialogDataG[3].content[3], label: dialogDataG[3].content[3]),
              MultiSelectCard(value: dialogDataG[3].content[4], label: dialogDataG[3].content[4]),
            ], onChange: (allSelectedItems, selectedItem) {
          selectedTools = allSelectedItems;
        }
        ),
      ],
    ),
    quickExit: false,
    setBackIcon: true,
    setNextIcon: true,
    cancelButton: true,
    prevDialog: () {
      Navigator.of(context).pop();
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
          return openDialogDate(context, gym);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    },
    nextDialog: () {
      if(selectedTools.isEmpty){
        const snackBar = SnackBar(
          content: Text(
            "You must choose",
            style: TextStyle(fontSize: 14),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        requirements.removeAt(3);
        requirements.insert(3, selectedTools);
        Navigator.pop(context);
        showAnimatedDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
            return openDialogHW(context, gym);
          }),
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
      }
    }
);

TextEditingController addHeight = TextEditingController();
TextEditingController addWeight = TextEditingController();
Widget openDialogHW(BuildContext context, gym) => defaultDialog(
  context: context,
  title: subTitleText(text: dialogDataG[4].title[0],maxLines: 2),
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
              borderSide: BorderSide(width: 1, color: BackgroundColors.whiteBG)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: BackgroundColors.whiteBG)),
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
              borderSide: BorderSide(width: 1, color: BackgroundColors.whiteBG)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: BackgroundColors.whiteBG)),
        ),
      ),
    ],
  ),
  quickExit: false,
  setBackIcon: true,
  setNextIcon: true,
  cancelButton: true,
  prevDialog: () {
    Navigator.of(context).pop();
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogWorkoutTools(context, gym);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );        },
  nextDialog: () {
    requirements.removeAt(3);
    requirements.insert(4, [addHeight.text, addWeight.text]);
    Navigator.pop(context);
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogInjuries(context, gym);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  },
);
List<String> selectedInjuries = [];
Widget openDialogInjuries(BuildContext context, gym) => defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[5].title[0],maxLines: 2),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MultiSelectContainer(
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
                MultiSelectCard(value: dialogDataG[5].content[0], label: dialogDataG[5].content[0]),
                MultiSelectCard(value: dialogDataG[5].content[1], label: dialogDataG[5].content[1]),
                MultiSelectCard(value: dialogDataG[5].content[2], label: dialogDataG[5].content[2]),
                MultiSelectCard(value: dialogDataG[5].content[3], label: dialogDataG[5].content[3]),
                MultiSelectCard(value: dialogDataG[5].content[4], label: dialogDataG[5].content[4]),
                MultiSelectCard(value: dialogDataG[5].content[5], label: dialogDataG[5].content[5]),
                MultiSelectCard(value: dialogDataG[5].content[6], label: dialogDataG[5].content[6]),
                MultiSelectCard(value: dialogDataG[5].content[7], label: dialogDataG[5].content[7]),
                MultiSelectCard(value: dialogDataG[5].content[8], label: dialogDataG[5].content[8]),
                MultiSelectCard(value: dialogDataG[5].content[9], label: dialogDataG[5].content[9]),
                MultiSelectCard(value: dialogDataG[5].content[10], label: dialogDataG[5].content[10]),
              ],
              onChange: (allSelectedItems, selectedItem) {
                selectedInjuries = allSelectedItems;
              }
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: DefaultButton(
              function: (){
                  isExerciseTaken = true;
                  gym.requirements(isExerciseTaken);
                  Navigator.pop(context);
                  print('$isExerciseTaken dialogs');
              },
              borderRadius: 30,
              text: "save",
            )
        )
      ],
    ),
    quickExit: false,
    setBackIcon: true,
    setNextIcon: false,
    cancelButton: true,
    prevDialog: () {
      Navigator.of(context).pop();
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
          return openDialogHW(context, gym);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );        },
);