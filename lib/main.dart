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
  // ipConnectionAddress2.then((value) {
  //   print(value);
  // });
  getDataMapValues(allValues: true).then((value) {
    print("successful exercise data from $value");
    getMeals().then((value) {
      print("successful meals data from $value");
      runApp(const MyApp());
    }).catchError((e){
      print("Unsuccessful meals data at $e");
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
      initialRoute: "/login",
      routes: routes,
    );
  }
}
