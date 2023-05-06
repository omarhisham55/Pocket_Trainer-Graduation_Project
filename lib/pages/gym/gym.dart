import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:calender_picker/calender_picker.dart';
import '../../data/gym_dialog_data.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import 'gymHome.dart';
import 'AddExercise.dart';

class Gym extends StatefulWidget {
  const Gym({Key? key}) : super(key: key);

  @override
  State<Gym> createState() => _GymState();
}
List<String> months = [
  "January","February","March","April","May","June","July","August","September","October","November","December"
];
Widget buildDaysOfWeek(void Function(DateTime) function) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // paragraphText(text: months[DateTime.now().month-1]),
      // const SizedBox(height: 10),
      CalenderPicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.black,
        daysCount: 6,
        onDateChange: function,
      ),
    ],
  );
}

class _GymState extends State<Gym> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeableAppBar(
        context: context,
        title: "Gym",
        isRequirementsTaken: true,
        replace: QudsPopupButton(tooltip: 'open', items: getMenuItemsGym(), child: const Icon(Icons.more_vert, color: Colors.white, size: 30)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: buildDaysOfWeek((date){}),
          ),
        ),
      ),
      backgroundColor: BackgroundColors.background,
      //safe area is empty gym page
      //exercise is full gym page
      body: (addTraining == -1)
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 100, right: 40, left: 40),
                child: Column(
                  children: [
                    Image.asset(GymImages.emptyGym),
                    titleText(text: "No schedule yet"),
                    const SizedBox(height: 20),
                    paragraphText(
                      text:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    DefaultButton(
                        function: () {
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => StatefulBuilder(
                                builder: (context, StateSetter setState) =>
                                    openDialogExperience(context)),
                            animationType: DialogTransitionType.sizeFade,
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(seconds: 1),
                          );
                        },
                        text: "Create")
                  ],
                ),
              ),
            )
          : const GymHome(),
    );
  }

  List<QudsPopupMenuBase> getMenuItemsGym() {
    return [
      QudsPopupMenuItem(
        leading: const Icon(Icons.add),
        title: const Text('Add Exercise'),
        onPressed: () {
          noNavNavigator(context, const AddExercise());
        },
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Delete training'),
          onPressed: () {
            setState(() {
              remove = true;
              print(remove);
            });
          }),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.info_outline),
          title: const Text('Training info'),
          onPressed: () {
            // showToast('Feedback Pressed!');
          }),
    ];
  }
}
