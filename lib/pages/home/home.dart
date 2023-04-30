import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/information/viewExercises.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, state) {},
        builder: (_, state) {
          CubitManager homeContent = CubitManager.get(_);
          return SafeArea(
            child: Scaffold(
              appBar: notificationAppBar(context, "Home"),
              body: Container(
                  color: BackgroundColors.background,
                  child: Column(
                    children: [
                      //Special offer section --carousel--
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: .8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              height: MediaQuery.of(context).size.height * 0.18,
                              scrollDirection: Axis.horizontal,
                              // onPageChanged: callbackFunction,
                            ),
                            items: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: BackgroundColors.offers,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Stack(children: [
                                        Image.asset(homeContent.specialOffer[0].image,
                                            width: double.infinity,
                                            alignment: Alignment.centerRight,
                                            fit: BoxFit.contain),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subTitleText(
                                                text: homeContent.specialOffer[0].title),
                                            const SizedBox(height: 10),
                                            paragraphText(
                                                text: homeContent.specialOffer[0].offer),
                                          ],
                                        )
                                      ]),
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: BackgroundColors.offers,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Stack(children: [
                                        Image.asset(homeContent.specialOffer[1].image,
                                            width: double.infinity,
                                            alignment: Alignment.centerRight,
                                            fit: BoxFit.contain),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subTitleText(
                                                text: homeContent.specialOffer[1].title),
                                            const SizedBox(height: 10),
                                            paragraphText(
                                                text: homeContent.specialOffer[1].offer),
                                          ],
                                        )
                                      ]),
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: BackgroundColors.offers,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Stack(children: [
                                        Image.asset(homeContent.specialOffer[2].image,
                                            width: double.infinity,
                                            alignment: Alignment.centerRight,
                                            fit: BoxFit.contain),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subTitleText(
                                                text: homeContent.specialOffer[2].title),
                                            const SizedBox(height: 10),
                                            paragraphText(
                                                text: homeContent.specialOffer[2].offer),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ))
                            ],
                          )),
                      //Muscular body image
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Center(
                              child: Image.asset(
                                  (homeContent.isFrontBody)
                                      ? MainImages.faceBody
                                      : MainImages.backBody,
                                  height: height(context, .6))),
                          Visibility(
                              visible: (homeContent.isFrontBody) ? true : false,
                              child: Positioned(
                                top: 70,
                                left: 40,
                                child: TextButton(
                                    onPressed: () {
                                      pageNavigator(
                                          context,
                                          InformationDetails(
                                              exerciseType: "Shoulders"));
                                    },
                                    child: subTitleText(text: "Shoulders")),
                              )),
                          Visibility(
                            visible: (homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 110,
                              left: 50,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Chest"));
                                  },
                                  child: subTitleText(text: "Chest")),
                            ),
                          ),
                          Visibility(
                            visible: (homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 120,
                              left: 300,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Biceps"));
                                  },
                                  child: subTitleText(text: "Biceps")),
                            ),
                          ),
                          Visibility(
                            visible: (homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 250,
                              left: 90,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Legs"));
                                  },
                                  child: subTitleText(text: "Legs")),
                            ),
                          ),
                          Visibility(
                            visible: (!homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 110,
                              left: 50,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Triceps"));
                                  },
                                  child: subTitleText(text: "Triceps")),
                            ),
                          ),
                          Visibility(
                            visible: (!homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 120,
                              left: 250,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Back"));
                                  },
                                  child: subTitleText(text: "Back")),
                            ),
                          ),
                          Visibility(
                            visible: (!homeContent.isFrontBody) ? true : false,
                            child: Positioned(
                              top: 270,
                              left: 90,
                              child: TextButton(
                                  onPressed: () {
                                    pageNavigator(
                                        context,
                                        InformationDetails(
                                            exerciseType: "Legs"));
                                  },
                                  child: subTitleText(text: "Legs")),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: IconButton(
                                onPressed: () {
                                  homeContent.changeBody();
                                },
                                icon: const Icon(FontAwesomeIcons.reply,
                                    color: TextColors.whiteText)),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
