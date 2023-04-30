import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../shared/components/components.dart';


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
        title: ["Add your weight and height"], content: ["weight", "height"]));
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

int addTraining = 0;
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
Widget openDialogExperience(BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState)=> defaultDialog(
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
            return openDialogGoal(context);
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
Widget openDialogGoal(BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState)=> defaultDialog(
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
          return openDialogExperience(context);
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
              return openDialogDate(context);
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
Widget openDialogDate(BuildContext context) => defaultDialog(
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
        return openDialogGoal(context);
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
          return openDialogWorkoutTools(context);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    }
  },
);
List<String> selectedTools = [];
Widget openDialogWorkoutTools(BuildContext context) => defaultDialog(
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
          return openDialogDate(context);
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
            return openDialogHW(context);
          }),
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
      }
    }
);
double height = 180;
double weight = 70;
Widget openDialogHW(BuildContext context) => defaultDialog(
  context: context,
  title: subTitleText(text: dialogDataG[4].title[0],maxLines: 2),
  body: Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset('images/man.png', height: 200, width: 150),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${weight.round()} ',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white
                      ),
                    ),
                    const Text(
                      'Kg',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '${height.round()} ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),
                      ),
                      const Text(
                        'cm',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: SizedBox(
                    width: 250,
                    child: Slider(
                      value: height,
                      max: 210,
                      min: 120,
                      activeColor: Colors.lightGreen,
                      inactiveColor: BackgroundColors.whiteBG,
                      onChanged: (value){
                        // setState(() {
                        //   height = value;
                        // });
                      },

                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Slider(
        value: weight,
        max: 200,
        min: 40,
        activeColor: BackgroundColors.selectedButton,
        inactiveColor: BackgroundColors.whiteBG,
        onChanged: (value){
          // setState(() {
          //   weight = value;
          // });
        },
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
        return openDialogWorkoutTools(context);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );        },
  nextDialog: () {
    requirements.removeAt(3);
    requirements.insert(4, [height.round(), weight.round()]);
    Navigator.pop(context);
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
        return openDialogInjuries(context);
      }),
      animationType: DialogTransitionType.sizeFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  },
);
List<String> selectedInjuries = [];
Widget openDialogInjuries(BuildContext context) => defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[5].title[0],maxLines: 2),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: MultiSelectContainer(
          itemsPadding: const EdgeInsetsDirectional.all(10),
          itemsDecoration: MultiSelectDecorations(
            decoration: BoxDecoration(
                color: BackgroundColors.extraButton,
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
          return openDialogHW(context);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );        },
    nextDialog: () {
      requirements.removeAt(5);
      requirements.insert(5, selectedInjuries);
      Navigator.pop(context);
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
          return openDialogInBody(context);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    }
);
List<double> measureInbody = [0, 0, 0, 0];
Widget openDialogInBody(BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState)=> defaultDialog(
    context: context,
    title: subTitleText(text: dialogDataG[6].title[0],maxLines: 2),
    body: Column(
      children: [
        Text(dialogDataG[6].subtitle![0], style: const TextStyle(color: TextColors.whiteText,fontSize: 18)),
        ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10,
                      left: 15.0
                  ),
                  child: Text(
                    dialogDataG[6].content[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '${measureInbody[index].round()}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.percent)
                    ],
                  ),
                ),
                Slider(
                  value: measureInbody[index],
                  max: 30,
                  min: 0,
                  activeColor: BackgroundColors.button,
                  inactiveColor: Colors.white,
                  onChanged: (value){
                    setState(() {
                      measureInbody[index] = value;
                    });
                  },
                ),
              ],
            ),
            itemCount: dialogDataG[6].content.length),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: DefaultButton(
              function: (){
                for(int i=0; i<measureInbody.length; i++){
                  if(measureInbody[i] == 0){
                    var snackBar = SnackBar(
                      content: Text(
                        "Inbody ${dialogDataG[6].content[i]} must not have 0",
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else{
                    requirements.removeAt(6);
                    requirements.insert(6, measureInbody);
                  }
                }
                setState((){
                  addTraining ++;
                  Navigator.pop(context);
                  // widget.gymRequirement = true;
                  print('$addTraining dialogs');
                });
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
          return openDialogInjuries(context);
        }),
        animationType: DialogTransitionType.sizeFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    }
));
