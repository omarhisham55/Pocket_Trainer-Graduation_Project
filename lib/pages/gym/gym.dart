import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:calender_picker/calender_picker.dart';
import '../../data/gym_dialog_data.dart';
import '../../data/userData.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import 'gymHome.dart';
import 'AddExercise.dart';

class Gym extends StatelessWidget {
  const Gym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {}),
        QudsPopupMenuDivider(),
        QudsPopupMenuItem(
            leading: const Icon(Icons.info_outline),
            title: const Text('Training info'),
            onPressed: () {
              // showToast('Feedback Pressed!');
            }),
      ];
    }

    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, snapshot){},
        builder: (_, snapshot){
          CubitManager gym = CubitManager.get(_);
          return Scaffold(
            appBar: (isExerciseTaken == false) ? notificationAppBar(context, "Gym") : null,
            backgroundColor: BackgroundColors.background,
            //safe area is empty gym page
            //exercise is full gym page
            body: (isExerciseTaken == false)
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
                          // User.currentUser!.workoutPlan = {};
                          // User.getProfile();
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) =>
                                StatefulBuilder(
                                    builder: (context, StateSetter setState) =>
                                        openDialogExperience(context, CubitManager.get(_))),
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
                : GymHome(),
          );
        },
      ),
    );
  }
}
