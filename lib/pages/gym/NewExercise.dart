import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExercise extends StatelessWidget {
  NewExercise({super.key});
  final exerciseNameController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();
  String dropDownValue = 'Muscle';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {},
        builder: (_, s) {
          CubitManager gym = CubitManager.get(_);
          return Scaffold(
            appBar: defaultAppBar(title: 'add Exercise', context: context),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        defaultTextFormField(
                          controller: exerciseNameController,
                          hint: "Exercise Name",
                          hintTexColor: TextColors.blackText,
                          textStyle: TextColors.blackText,
                          textAlign: TextAlign.start,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(border: Border.all(width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: defaultDropDownMenu(
                                    content: [
                                      'Shoulders',
                                      'Chest',
                                      'Back',
                                      'Arms',
                                      'Legs'
                                    ],
                                    hintValue: dropDownValue,
                                    textColor: TextColors.blackText,
                                    hintColor: TextColors.blackText,
                                    function: (value) {
                                      gym.dropDownSelect(value, dropDownValue);
                                    }),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width: width(context, .4),
                                  child: defaultTextFormField(
                                    controller: setsController,
                                    textInputType: TextInputType.number,
                                    hint: "Sets",
                                    hintTexColor: TextColors.blackText,
                                    textStyle: TextColors.blackText,
                                    textAlign: TextAlign.start,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context, .4),
                                  child: defaultTextFormField(
                                    controller: repsController,
                                    textInputType: TextInputType.number,
                                    hint: "Reps",
                                    hintTexColor: TextColors.blackText,
                                    textStyle: TextColors.blackText,
                                    textAlign: TextAlign.start,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: <Widget>[
                              subTitleText(
                                  text: "Upload Exercise photo/video",
                                  color: TextColors.blackText),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.upload_file,
                                    color: Colors.black,
                                    size: 30,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          DefaultButton(
                              function: () {
                                showSnackBar(context: context, text: "Future Plan!");
                              },
                              borderRadius: 20,
                              backgroundColor: BackgroundColors.button,
                              text: "Save"),
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
