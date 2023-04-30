import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/login_signup/login_signup.dart';
import 'package:final_packet_trainer/pages/profile/premiumPlans.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/cubit/cubit.dart';
import '../../shared/components/components.dart';

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
            body: SafeArea(
              child: Column(
                  children: [
                    //heading section
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: BackgroundColors.dialogBG,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage('https://img.search.brave.com/rDyllrwwpvfoJQmRSbGQDH6XvjvF2i9ot7sZp_LPUVU/rs:fit:479:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC4x/a0V0a05fNUhES0RF/YTdPUXJTbEd3SGFI/ViZwaWQ9QXBp'),
                            ),
                            const SizedBox(height: 10),
                            titleText(text: "Name")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //current program button
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: BackgroundColors.blueGradient
                      ),
                      child: DefaultButton(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: Colors.transparent,
                        function: (){},
                        borderRadius: 30,
                        text: "Current Program",
                      ),
                    ),
                    const SizedBox(height: 10),
                    //premium plans button
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: BackgroundColors.purpleGradient
                      ),
                      child: DefaultButton(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: Colors.transparent,
                        function: (){
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
                      function: (){},
                      text: "Contact us",
                    ),
                    DefaultButton(
                      width: MediaQuery.of(context).size.width,
                      backgroundColor: BackgroundColors.dialogBG,
                      function: (){},
                      text: "Terms & Conditions",
                    ),
                    DefaultButton(
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: BackgroundColors.dialogBG,
                        function: (){},
                        text: "Privacy Policy"
                    ),
                    DefaultButton(
                      width: MediaQuery.of(context).size.width,
                      backgroundColor: BackgroundColors.dialogBG,
                      function: (){
                        noNavNavigator(context, Login());
                      },
                      text: "Logout",
                    )
                  ]
              ),
            ),
          );
        }
      )
    );
  }
}
