import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/exerciseData.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';

class GymHome extends StatefulWidget {
  const GymHome({Key? key}) : super(key: key);

  @override
  State<GymHome> createState() => _GymHomeState();
}

bool remove = false;

class _GymHomeState extends State<GymHome> {
  final exercisePanelController = PanelController();
  List<String> titles = [
    GetGymPageContent().gymPageContent.keys.elementAt(0),
    GetGymPageContent().gymPageContent.keys.elementAt(1),
    GetGymPageContent().gymPageContent.keys.elementAt(2)
  ];
  List<List<String>>? warmUp = GetGymPageContent().getWarmUp();
  List<List<String>> exercise = GetGymPageContent().getExercise()!;
  List<List<String>>? stretches = GetGymPageContent().getStretches();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: BackgroundColors.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SlidingUpPanel(
            controller: exercisePanelController,
            maxHeight: height(context, .4),
            minHeight: 0.0,
            defaultPanelState: PanelState.CLOSED,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            //sliding up panel used to start exercise "CAMERA"
            panelBuilder: (panelBuilder) => SafeArea(
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(
                              text: "titles[indexA]",
                              color: TextColors.blackText),
                          const SizedBox(height: 20),
                          subTitleText(
                              text: "X sets . X reps",
                              color: TextColors.blackText),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              GymImages.gymBg,
                              width: width(context, 1),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DefaultButton(
                          function: () {
                            exercisePanelController.close();
                          },
                          text: "Start",
                          borderRadius: 30,
                          width: MediaQuery.of(context).size.width * .4,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  //warmUp
                  Column(
                    children: [
                      //green circle, title
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          const SizedBox(width: 7),
                          paragraphText(text: titles[0])
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: BackgroundColors.inkWellBG,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, i) => defaultInkWell(
                                  image: GymImages.gymBg,
                                  title: warmUp![i][0],
                                  subtitle: subTitleText(text: warmUp![i][1]),
                                  child: Row(
                                    children: [
                                      paragraphText(text: "Sets 3"),
                                      const SizedBox(width: 50),
                                      paragraphText(text: "Reps 3"),
                                    ],
                                  ),
                                  function: () {
                                    print(warmUp);
                                    print(remove);
                                    (exercisePanelController.isPanelClosed)
                                        ? exercisePanelController.open()
                                        : exercisePanelController.close();
                                  },
                                  remove: remove,
                                  removeFunction: () {
                                    setState(() {
                                      warmUp!.removeAt(i);
                                    });
                                  }),
                              separatorBuilder: (_, i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  BackgroundColors.background)),
                                    ),
                                  ),
                              itemCount: warmUp!.length))
                    ],
                  ),
                  const SizedBox(height: 15),
                  //exercise
                  Column(
                    children: [
                      //green circle, title
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          const SizedBox(width: 7),
                          paragraphText(text: titles[1])
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: BackgroundColors.inkWellBG,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, i) => defaultInkWell(
                                  image: GymImages.gymBg,
                                  title: exercise[i][0],
                                  subtitle: subTitleText(text: exercise[i][1]),
                                  child: Row(
                                    children: [
                                      paragraphText(text: "Sets 3"),
                                      const SizedBox(width: 50),
                                      paragraphText(text: "Reps 3"),
                                    ],
                                  ),
                                  function: () {
                                    (exercisePanelController.isPanelClosed)
                                        ? exercisePanelController.open()
                                        : exercisePanelController.close();
                                  },
                                  remove: remove,
                                  removeFunction: () {
                                    setState(() {
                                      exercise.removeAt(i);
                                    });
                                  }),
                              separatorBuilder: (_, i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  BackgroundColors.background)),
                                    ),
                                  ),
                              itemCount: exercise.length))
                    ],
                  ),
                  const SizedBox(height: 15),
                  //stretches
                  Column(
                    children: [
                      //green circle, title
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          const SizedBox(width: 7),
                          paragraphText(text: titles[2])
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: BackgroundColors.inkWellBG,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, i) => defaultInkWell(
                                  image: GymImages.gymBg,
                                  title: stretches![i][0],
                                  subtitle:
                                      subTitleText(text: stretches![i][1]),
                                  child: Row(
                                    children: [
                                      paragraphText(text: "Sets 3"),
                                      const SizedBox(width: 50),
                                      paragraphText(text: "Reps 3"),
                                    ],
                                  ),
                                  function: () {
                                    (exercisePanelController.isPanelClosed)
                                        ? exercisePanelController.open()
                                        : exercisePanelController.close();
                                  },
                                  remove: remove,
                                  removeFunction: () {
                                    setState(() {
                                      stretches!.removeAt(i);
                                    });
                                  }),
                              separatorBuilder: (_, i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  BackgroundColors.background)),
                                    ),
                                  ),
                              itemCount: stretches!.length))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: (remove) ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: DefaultButton(
                  function: () {
                    setState(() {
                      remove = false;
                    });
                  },
                  text: "Done",
                  backgroundColor: Colors.red,
                ),
              ))
        ],
      ),
    ));
  }
}
