// ignore_for_file: avoid_print

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:final_packet_trainer/shared/styles/images.dart';
import 'package:flutter/material.dart';
import 'data/nutritionData.dart';
import 'login_signup/login_signup.dart';
import 'navigation/routes.dart';
import 'notification/notification_initialize.dart';
import 'shared/blocObserver.dart';

List<CameraDescription>? camera;

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();
  AwesomeNotifications()
      .initialize(
          null,
          [
            NotificationChannel(
                channelKey: 'pocket01',
                channelName: 'Pocket Trainer',
                channelDescription: 'Smart Gym App')
          ],
          debug: true)
      .then((value) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }

      NotificationService().scheduleNotifications();
    }).catchError((e) {
      print('lola $e');
    });
  });
  // getBackExercises().then((value) => print('lolo')).catchError((e)=>print('popo $e'));
  getDataMapValues(allValues: true).then((value) {
    print("successful exercise data from ${value.length}");
    getBreakfast().then((value) {
      print("successful breakfast data from ${value.length}");
      getLunch().then((value) {
        print("successful lunch data from ${value.length}");
        getDinner().then((value) {
          print("successful dinner data from ${value.length}");
          runApp(const MyApp());
        }).catchError((e) {
          print("Unsuccessful dinner data at $e");
          print("App will not open");
        });
      }).catchError((e) {
        print("Unsuccessful lunch data at $e");
        print("App will not open");
      });
    }).catchError((e) {
      print("Unsuccessful breakfast data at $e");
      print("App will not open");
    });
  }).catchError((e) {
    print("Unsuccessful exercise data at $e");
    print("App will not open");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: routes,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      logoNavigator(context, const Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColors.background,
      body: Center(
        child: Image.asset(MainImages.logo),
      ),
    );
  }
}
