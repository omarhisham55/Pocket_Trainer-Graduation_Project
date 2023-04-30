import 'package:final_packet_trainer/data/offers.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import '../../shared/styles/colors.dart';
import 'payment_method.dart';
//Done

class PremiumPlans extends StatelessWidget {
  PremiumPlans({Key? key}) : super(key: key);
  late String title;
  late double cost;
  late int duration;
  late Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CubitManager>(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, state){},
        builder: (_, state)
        {
          CubitManager isClicked = CubitManager.get(_);
          return Container(
              decoration:
                  const BoxDecoration(gradient: BackgroundColors.blackGradient),
              child: SafeArea(
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    title: Center(child: titleText(text: "Premium Plans")),
                    actions: const [
                      Icon(
                        Icons.notifications_on,
                        color: Colors.transparent,
                        size: 45,
                      )
                    ],
                  ),
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //premium offer
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(GymImages.gymBg,
                                opacity: const AlwaysStoppedAnimation(.5)),
                            Positioned(
                              bottom: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: subTitleText(
                                    text: "Get 3 months of Premium for free"),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: DefaultButton(
                                    width: double.infinity,
                                    function: () {},
                                    backgroundColor: BackgroundColors.button,
                                    borderRadius: 30,
                                    text: "Get 3 months free"))
                          ],
                        ),
                        //Silver plan
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: () {
                                isClicked.isSliverClicked();
                              },
                              child: AnimatedContainer(
                                  height: isClicked.isClicked
                                      ? MediaQuery.of(context).size.height * .3
                                      : MediaQuery.of(context).size.height *
                                          .28,
                                  duration: const Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width:
                                            isClicked.isClicked
                                                ? 3
                                                : 0,
                                        color:
                                            isClicked.isClicked
                                                ? BackgroundColors.button
                                                : Colors.transparent,
                                      )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            titleText(text: premiumPlansContent["Silver"]![0]),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                subTitleText(
                                                    text: "${premiumPlansContent["Silver"]![1]} EGP",
                                                    size: 25),
                                                paragraphText(
                                                    text:
                                                        "for ${premiumPlansContent["Silver"]![2]} months")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: paragraphText(
                                            text: """- AI Movement scanning
- Real time analysis & guidance
- Exercise execution counting
- Burned calories counting
- Individual Training analysis
- Dynamic AI training plan
- Home / Gym / Box / Outside""",
                                            color: TextColors.blackText,
                                          )),
                                    ],
                                  )),
                            )),
                        //gold plan
                        InkWell(
                          onTap: () {
                            isClicked.isGoldClicked();
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: AnimatedContainer(
                                  height: !isClicked.isClicked
                                      ? MediaQuery.of(context).size.height * .3
                                      : MediaQuery.of(context).size.height *
                                          .28,
                                  duration: const Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width:
                                            !isClicked.isClicked
                                                ? 3
                                                : 0,
                                        color:
                                            !isClicked.isClicked
                                                ? BackgroundColors.button
                                                : Colors.transparent,
                                      )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            titleText(text: premiumPlansContent["Gold"]![0]),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                subTitleText(
                                                    text: "${premiumPlansContent["Gold"]![1]} EGP",
                                                    size: 25),
                                                paragraphText(
                                                    text:
                                                        "for ${premiumPlansContent["Gold"]![2]} months")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: paragraphText(
                                              text: """- AI Movement scanning
- Real time analysis & guidance
- Exercise execution counting
- Burned calories counting
- Individual Training analysis
- Dynamic AI training plan
- Home / Gym / Box / Outside""", color: TextColors.blackText)),
                                    ],
                                  ))),
                        ),
                        //Submit button
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: DefaultButton(
                              width: MediaQuery.of(context).size.width * .5,
                              function: () {
                                print(isClicked.paymentMethod());
                                premiumNavigator(context, const PaymentMethod());
                              },
                              backgroundColor: BackgroundColors.button,
                              borderRadius: 30,
                              text: "Submit plan",
                            )),
                      ]),
                ),
              ));
        },
      ),
    );
  }
}
