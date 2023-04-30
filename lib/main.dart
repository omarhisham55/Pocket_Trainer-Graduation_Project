import 'package:bloc/bloc.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/data/userData.dart';
import 'package:final_packet_trainer/shared/network/networkConnectionCheck.dart';
import 'package:flutter/material.dart';
import 'navigation/routes.dart';
import 'shared/blocObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  ipConnectionAddress2.then((value) {
    print(value);
  });
  getDataMapValues().then((value) {
    print("successful exercise data from $value");
    getMeals().timeout(const Duration(seconds: 10));
    login();
    runApp(const MyApp());
    // getStretchesValues().then((value) {
    //   print("successful stretches data from $value");
    // }).catchError((e){
    //   print("Unsuccessful stretches data at $e");
    //   print("App will not open");
    // });
  }).catchError((e) {
    print("Unsuccessful exercise data at $e");
    if(e.toString().toLowerCase() == "connection refused"){
      print("Check internet connection or change IP address");
    }
    if(e.toString().toLowerCase() == "Connection timed out"){
      print("NodeJs not connected $e");
    }
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
      initialRoute: "/",
      routes: routes,
    );
  }
}
