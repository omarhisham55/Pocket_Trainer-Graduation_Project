// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class LogoAnimation extends PageRouteBuilder{
  final page;
  LogoAnimation({this.page}): super(
      pageBuilder: (context, animation, animationtwo) => page,
      transitionsBuilder: (context, animation, animationtwo, child) {
        var begin = 4.0;
        var end = 1.0;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
        return ScaleTransition(scale: tween.animate(curveAnimation), child: FadeTransition(opacity: animation, child: child));
      }
  );
}

class HomeAnimation extends PageRouteBuilder{
  final page;
  HomeAnimation({this.page}): super(
      pageBuilder: (context, animation, animationtwo) => page,
      transitionsBuilder: (context, animation, animationtwo, child) {
        //according to offset transition will be up, down, left or right
        var begin = const Offset(0, 1);
        var end = Offset.zero;
        // ignore: unused_local_variable
        var tween = Tween(begin: begin, end: end);
        var curveAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
        return SizeTransition(sizeFactor: curveAnimation, child: child);
      }
  );
}

class PremiumAnimation extends PageRouteBuilder{
  final page;
  PremiumAnimation({this.page}): super(
      pageBuilder: (context, animation, animationtwo) => page,
      transitionsBuilder: (context, animation, animationtwo, child) {
        //according to offset transition will be up, down, left or right
        var begin = const Offset(0, -1);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
        return SlideTransition(position: tween.animate(curveAnimation), child: child);
      }
  );
}

class PageAnimation extends PageRouteBuilder{
  final page;
  PageAnimation({this.page}): super(
      pageBuilder: (context, animation, animationtwo) => page,
      transitionsBuilder: (context, animation, animationtwo, child) {
        //according to offset transition will be up, down, left or right
        var begin = 0.0;
        var end = 1.0;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
        return ScaleTransition(scale: tween.animate(curveAnimation), child: child);
      }
  );
}

class NotificationAnimation extends PageRouteBuilder{
  final page;
  NotificationAnimation({this.page}): super(
      pageBuilder: (context, animation, animationtwo) => page,
      transitionsBuilder: (context, animation, animationtwo, child) {
        //according to offset transition will be up, down, left or right
        var begin = const Offset(1, 0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation = CurvedAnimation(parent: animation, curve: Curves.slowMiddle);
        return SlideTransition(position: tween.animate(curveAnimation), child: child);
      }
  );
}