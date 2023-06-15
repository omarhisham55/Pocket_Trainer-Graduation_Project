import 'package:bloc/bloc.dart';
import 'package:dashboard/bloc/bloc_observer.dart';
import 'package:dashboard/data/exercise_data.dart';
import 'package:flutter/material.dart';

import 'pages/navigation/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  getDataMapValues(allValues: true)
      .then((value) => runApp(const PocketTrainerDashBoard()))
      .catchError((e) => throw e);
}

class PocketTrainerDashBoard extends StatelessWidget {
  const PocketTrainerDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
