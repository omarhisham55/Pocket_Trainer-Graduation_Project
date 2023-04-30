import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/nutrition/nutritionHome.dart';
import 'package:final_packet_trainer/pages/gym/gym.dart';
import 'package:final_packet_trainer/pages/home/home.dart';
import 'package:final_packet_trainer/pages/information/information.dart';
import 'package:final_packet_trainer/pages/nutrition/nutrition.dart';
import 'package:final_packet_trainer/pages/profile/profile.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/images.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, state) {},
        builder: (_, state) {
          CubitManager navController = CubitManager.get(_);
          return WillPopScope(
            onWillPop: () async {
              // print("index =  ${controller.index}");
              //   await showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         backgroundColor: BackgroundColors.dialogBG,
              //         title: subTitleText(text: "Are you sure you want to exit?"),
              //         actions: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               DefaultButton(
              //                 function: (){
              //                   SystemNavigator.pop();
              //                 },
              //                 text: "Yes",
              //                 width: width(context, .3),
              //                 backgroundColor: Colors.transparent,
              //               ),
              //               DefaultButton(
              //                 function: (){
              //                   Navigator.pop(context);
              //                 },
              //                 text: "No",
              //                 width: width(context, .3),
              //                 backgroundColor: Colors.transparent,
              //               ),
              //             ],
              //           )
              //         ],
              //       );
              //     },
              //   );
              return false; // Prevent back navigation
            },
            child: PersistentTabView(
              context,
              controller: navController.controller,
              screens: navController.screens(),
              items: navController.navBarsItems(),
              confineInSafeArea: true,
              backgroundColor: BackgroundColors.dialogBG,
              // Default is Colors.white.
              handleAndroidBackButtonPress: true,
              // Default is true.
              resizeToAvoidBottomInset: true,
              // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true,
              // Default is true.
              hideNavigationBarWhenKeyboardShows: true,
              // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 100),
              ),
              navBarStyle: NavBarStyle
                  .style14, // Choose the nav bar style with this property.
            ),
          );
        },
      ),
    );
  }
}
