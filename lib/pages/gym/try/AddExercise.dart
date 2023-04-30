import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/styles/images.dart';
import '../../information/viewExercises.dart';
import 'ExistExercise.dart';
import 'NewExercise.dart';

class AddExercise extends StatefulWidget {
  const AddExercise({super.key});

  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  bool isFrontBody = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'add Exercise', context: context),
          body: SafeArea(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Center(
                        child: Image.asset(
                            (isFrontBody) ? MainImages.faceBody : MainImages.backBody,
                        )
                    ),
                    Visibility(
                        visible: (isFrontBody) ? true : false,
                        child: Positioned(
                          top: 200,
                          left: 40,
                          child: TextButton(
                              onPressed: (){
                                pageNavigator(context, InformationDetails(exerciseType: "Shoulders"));
                              },
                              child: subTitleText(text: "Shoulders", color: TextColors.blackText)
                          ),
                        )
                    ),
                    Visibility(
                      visible: (isFrontBody) ? true : false,
                      child: Positioned(
                        top: 240,
                        left: 50,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Chest"));
                            },
                            child: subTitleText(text: "Chest", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (isFrontBody) ? true : false,
                      child: Positioned(
                        top: 250,
                        left: 300,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Arms"));
                            },
                            child: subTitleText(text: "Arms", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (isFrontBody) ? true : false,
                      child: Positioned(
                        top: 380,
                        left: 90,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Legs"));
                            },
                            child: subTitleText(text: "Legs", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (!isFrontBody) ? true : false,
                      child: Positioned(
                        top: 240,
                        left: 50,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Arms"));
                            },
                            child: subTitleText(text: "Arms", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (!isFrontBody) ? true : false,
                      child: Positioned(
                        top: 250,
                        left: 250,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Back"));
                            },
                            child: subTitleText(text: "Back", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (!isFrontBody) ? true : false,
                      child: Positioned(
                        top: 410,
                        left: 90,
                        child: TextButton(
                            onPressed: (){
                              pageNavigator(context, InformationDetails(exerciseType: "Legs"));
                            },
                            child: subTitleText(text: "Legs", color: TextColors.blackText)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: IconButton(
                          onPressed: (){
                            setState(() {
                              isFrontBody = !isFrontBody;
                            });
                          },
                          icon: const Icon(FontAwesomeIcons.reply, color: TextColors.blackText)),
                    )
                  ],
                )
          ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DefaultButton(
              function: (){
                navNavigator(context, const ExistExercise());
              },
              text: "Add existing exercise",
              bigButton: false,
              backgroundColor: BackgroundColors.selectedButton,
              borderRadius: 30.0,
              textColor: TextColors.blackText,
            ),
            DefaultButton(
              function: () {
                navNavigator(context, NewExercise());
              },
              text: "Add new exercise",
              bigButton: false,
              backgroundColor: BackgroundColors.whiteBG,
              borderRadius: 30.0,
              textColor: TextColors.recommendedText,
            )
          ],
        ),
      ),
    );
  }
}

