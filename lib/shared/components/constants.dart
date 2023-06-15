import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../navigation/animationNavigation.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PageTransitionAnimation scale = PageTransitionAnimation.scale;
PageTransitionAnimation fade = PageTransitionAnimation.fade;
PageTransitionAnimation slideRight = PageTransitionAnimation.slideRight;
PageTransitionAnimation slideUp = PageTransitionAnimation.slideUp;
PageTransitionAnimation sizeUp = PageTransitionAnimation.sizeUp;

void notificationNavigator(context, page) {
  Navigator.of(context).push(NotificationAnimation(page: page));
}

Future<void> pageNavigator(context, page) async {
  Navigator.of(context).push(PageAnimation(page: page));
}

void homeNavigator(context, page) {
  Navigator.of(context).push(HomeAnimation(page: page));
}

void premiumNavigator(context, page) {
  Navigator.of(context).push(PremiumAnimation(page: page));
}

void logoNavigator(context, page) {
  Navigator.of(context).push(LogoAnimation(page: page));
}

Future<void> popPage(context) async {
  Navigator.pop(context);
}

void pushReplacement(context, page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

void noNavNavigator(context, page) {
  PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: page,
    withNavBar: false, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: slideUp,
  );
}

void navNavigator(context, page) {
  PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: page,
    withNavBar: true, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: sizeUp,
  );
}

double width(context, double? newWidth) {
  return MediaQuery.of(context).size.width * newWidth!;
}

double height(context, double? newHeight) {
  return MediaQuery.of(context).size.height * newHeight!;
}

int generateStretchDuration() {
  Random random = Random();
  int number;

  do {
    number = random.nextInt(16) +
        15; // Generates a random number between 15 and 30 (inclusive)
  } while (number % 5 !=
      0); // Continues generating until a number divisible by 5 is obtained

  return number;
}
