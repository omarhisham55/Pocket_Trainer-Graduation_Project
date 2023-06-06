import 'package:final_packet_trainer/shared/styles/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/cubit/cubit.dart';
import '../../navigation/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class GymRecommendedPlan extends StatelessWidget {
  final List? requirements;
  final bool? fromHome;
  const GymRecommendedPlan({Key? key, this.requirements, this.fromHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {},
        builder: (_, s) {
          List trainingDays = [];
          var isFromHome = fromHome ?? false;
          for (var value in requirements![2]) {
            if (value == "Working Day") {
              trainingDays.add(value);
            }
          }
          return WillPopScope(
            onWillPop: () async {
              return false; // Prevent back navigation
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: const Icon(Icons.arrow_back_ios,
                      color: Colors.transparent),
                  title: Center(child: titleText(text: 'Diet information')),
                  actions: [
                    Visibility(
                        visible: (isFromHome) ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: TextColors.whiteText, size: 30),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ))
                  ]),
              body: Stack(
                children: [
                  Image.asset(GymImages.gymBg,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      height: height(context, .3)),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 200),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText(
                                text: "Your gym requirements",
                                color: TextColors.blackText,
                                fontWeight: FontWeight.w700),
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //number of days
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Days per week: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text:
                                              "${trainingDays.length.toString()} days",
                                          color: BackgroundColors.offers,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //goal
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Goal: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text: requirements![1].toString(),
                                          color: BackgroundColors.offers,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    //tool
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Training place: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text: requirements![3].toString(),
                                          color: BackgroundColors.offers,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //level
                                    Row(
                                      children: [
                                        paragraphText(
                                          text: "Level: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        paragraphText(
                                          text: requirements![0].toString(),
                                          color: BackgroundColors.offers,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //notes
                                    Wrap(
                                      children: [
                                        paragraphText(
                                          text:
                                              "General instructions for the plan: ",
                                          color: TextColors.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: paragraphText(
                                              text: "generalData",
                                              color: TextColors.blackText,
                                              fontWeight: FontWeight.w700,
                                              maxLines: 17,
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Set as default button
                  Positioned(
                    bottom: 50,
                    left: width(context, .25),
                    child: Visibility(
                      visible: (isFromHome) ? false : true,
                      child: DefaultButton(
                          function: () {
                            Navigator.pop(context, requirements);
                          },
                          width: width(context, .5),
                          borderRadius: 30,
                          text: 'Set as default'),
                    ),
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
