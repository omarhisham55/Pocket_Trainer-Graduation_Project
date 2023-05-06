import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/styles/images.dart';
import '../information/viewExercises.dart';
import 'ExistExercise.dart';
import 'NewExercise.dart';

class AddExercise extends StatelessWidget {
  const AddExercise({super.key});
  // final bool gym.isFrontBody = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s){},
        builder: (_, s){
          CubitManager gym = CubitManager.get(_);
          return Scaffold(
            appBar: defaultAppBar(title: 'add Exercise', context: context),
            body: SafeArea(
                child: GestureDetector(
                  onHorizontalDragEnd: (detail){
                    gym.changeBody();
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Center(
                          child: Image.asset(
                            (gym.isFrontBody) ? MainImages.faceBody : MainImages.backBody,
                          )
                      ),
                      Visibility(
                          visible: (gym.isFrontBody) ? true : false,
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
                        visible: (gym.isFrontBody) ? true : false,
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
                        visible: (gym.isFrontBody) ? true : false,
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
                        visible: (gym.isFrontBody) ? true : false,
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
                        visible: (!gym.isFrontBody) ? true : false,
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
                        visible: (!gym.isFrontBody) ? true : false,
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
                        visible: (!gym.isFrontBody) ? true : false,
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
                              gym.changeBody();
                            },
                            icon: const Icon(FontAwesomeIcons.reply, color: TextColors.blackText)),
                      )
                    ],
                  ),
                )
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultButton(
                    function: (){
                      navNavigator(context, ExistExercise());
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
        },
      ),
    );
  }
}
