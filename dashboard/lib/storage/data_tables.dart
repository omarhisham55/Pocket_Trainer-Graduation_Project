import 'dart:convert';

import 'package:dashboard/data/exercise_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Saving the list
void saveExerciseData(List<Exercise> exercise) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = jsonEncode(exercise);
  prefs.setString('exerciseData', jsonList);
  print(prefs);
}

// Retrieving the list
Future<List<dynamic>> getExerciseData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = prefs.getString('exerciseData')!;
  if (jsonList.isNotEmpty) {
    return List<dynamic>.from(jsonDecode(jsonList));
  }
  return [];
}