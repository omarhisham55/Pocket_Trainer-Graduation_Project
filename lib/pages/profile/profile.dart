import 'package:final_packet_trainer/data/userData.dart';
import 'package:final_packet_trainer/main.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/gym_dialog_data.dart';
import '../../login_signup/login_signup.dart';
import 'package:final_packet_trainer/pages/profile/premiumPlans.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
            listener: (_, s) {},
            builder: (_, s) {
              return Scaffold(
                backgroundColor: BackgroundColors.background,
                appBar: notificationAppBar(context, "Profile"),
                body: FutureBuilder(
                  future: User.getProfile(),
                  builder: (_, snapshot){
                  if(snapshot.hasData){
                    var user = snapshot.data!;
                    return SafeArea(
                      child: Column(children: [
                        //heading section
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: BackgroundColors.dialogBG,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(30))),
                          child: SizedBox(
                              width: width(context, 1),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(MainImages.emptyImage),
                                            // foregroundImage: NetworkImage(user['photo'] ?? ""),
                                          ),
                                          const SizedBox(height: 10),
                                          titleText(text: user['name'])
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 10.0,
                                      top: 5.0,
                                      child: Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.edit,
                                                color: BackgroundColors.whiteBG,
                                              )
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: BackgroundColors.dialogBG,
                                                      title: subTitleText(text: "Are you sure you want to delete your account?"),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              child: DefaultButton(
                                                                function: () {},
                                                                text: "Yes",
                                                                backgroundColor: Colors.red,
                                                                width: width(context, .3),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              child: DefaultButton(
                                                                function: () {},
                                                                text: "No",
                                                                backgroundColor:
                                                                BackgroundColors.button,
                                                                width: width(context, .3),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.trash,
                                                color: BackgroundColors.whiteBG,
                                              )),
                                        ],
                                      )),
                                ],
                              )),
                        ),
                        const SizedBox(height: 10),
                        //current program button
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: BackgroundColors.blueGradient),
                          child: DefaultButton(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            backgroundColor: Colors.transparent,
                            function: () {
                              print(requirements);
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
                            borderRadius: 30,
                            text: "Current Program",
                          ),
                        ),
                        const SizedBox(height: 10),
                        //premium plans button
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: BackgroundColors.purpleGradient),
                          child: DefaultButton(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            backgroundColor: Colors.transparent,
                            function: () {
                              noNavNavigator(context, PremiumPlans());
                            },
                            borderRadius: 30,
                            text: "Premium Plans",
                          ),
                        ),
                        const Spacer(),
                        DefaultButton(
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: BackgroundColors.dialogBG,
                          function: () {},
                          text: "Contact us",
                        ),
                        DefaultButton(
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: BackgroundColors.dialogBG,
                          function: () {},
                          text: "Terms & Conditions",
                        ),
                        DefaultButton(
                            width: MediaQuery.of(context).size.width,
                            backgroundColor: BackgroundColors.dialogBG,
                            function: () {},
                            text: "Privacy Policy"),
                        DefaultButton(
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: BackgroundColors.dialogBG,
                          function: () {
                            User.token = null.toString();
                            noNavNavigator(context, const Login());
                          },
                          text: "Logout",
                        )
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: titleText(
                            text: "Error fetching data ${snapshot.error}", color: TextColors.blackText));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                  }
                )
              );
            }
            )
    );
  }
}
