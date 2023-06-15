import 'dart:convert';
import 'package:http/http.dart' as http;

class Exercise {
  String exerciseId;
  String exerciseName;
  String exerciseType;
  String exerciseBodyPart;
  String exerciseLevel;
  String exerciseEquipment;
  // String exerciseTarget;
  String exerciseDescription;
  // String exerciseTips;
  String exerciseRepetition;
  String exerciseSets;
  String exerciseImage;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseType,
    required this.exerciseBodyPart,
    required this.exerciseEquipment,
    required this.exerciseLevel,
    // required this.exerciseTarget,
    required this.exerciseDescription,
    // required this.exerciseTips,
    required this.exerciseRepetition,
    required this.exerciseSets,
    required this.exerciseImage,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json["_id"] ?? "",
      exerciseName: json["Title"] ?? "",
      exerciseBodyPart: json["BodyPart"] ?? "",
      exerciseType: json["Type"] ?? "",
      // exerciseTarget: json["target"],
      exerciseDescription: json["Desc"] ?? "",
      exerciseLevel: json["Level"] ?? "",
      exerciseEquipment: json["Equipment"] ?? "",
      // exerciseTips: json["tips"] ?? "",
      exerciseRepetition: json["Reps"] ?? "",
      exerciseSets: json["Sets"] ?? "",
      exerciseImage: json["imageUrl"] ?? "",
    );
  }
}

String url = "https://webservise-pockettrainer.onrender.com";

//get exercises
Future<List> getChestExercises() async {
  var chestExercises = await http.get(Uri.parse('$url/chest/exercises'));
  if (chestExercises.statusCode == 200) {
    var data = json.decode(chestExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getBackExercises() async {
  var backExercises = await http.get(Uri.parse('$url/back/exercises'));
  if (backExercises.statusCode == 200) {
    var data = json.decode(backExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    return [
      'Failed to load data ${backExercises.body} ${backExercises.statusCode}'
    ];
  }
}

Future<List> getShoulderExercises() async {
  var shoulderExercises = await http.get(Uri.parse('$url/shoulder/exercises'));
  if (shoulderExercises.statusCode == 200) {
    var data = json.decode(shoulderExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getArmExercises() async {
  var armExercises = await http.get(Uri.parse('$url/arm/exercises'));
  if (armExercises.statusCode == 200) {
    var data = json.decode(armExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getLegExercises() async {
  var legExercises = await http.get(Uri.parse('$url/leg/exercises'));
  if (legExercises.statusCode == 200) {
    var data = json.decode(legExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getCoreExercises() async {
  var legExercises = await http.get(Uri.parse('$url/abdominals/exercises'));
  if (legExercises.statusCode == 200) {
    var data = json.decode(legExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Map<String, Future<List>> allExercise = {
  "Chest": getChestExercises(),
  "Back": getBackExercises(),
  "Shoulders": getShoulderExercises(),
  "Arms": getArmExercises(),
  "Core": getCoreExercises(),
  "Legs": getLegExercises(),
};
Map<String, List<dynamic>> exerciseData = {};

Future<List> getDataMapValues({String? key = "", bool? allValues}) async {
  if (allValues == true && key == "") {
    // Wait for all futures to complete
    for (String key in allExercise.keys) {
      exerciseData[key] = await allExercise[key]!;
    }
    List values = [];
    for (String key in exerciseData.keys) {
      values.addAll(exerciseData[key]!);
    }
    return values;
  } else if (key == "") {
    List keys = [];
    // Wait for all futures to complete
    for (String key in allExercise.keys) {
      keys.add(key);
    }
    return keys;
  } else if (key != "") {
    // Wait for all futures to complete
    for (String key in allExercise.keys) {
      exerciseData[key] = await allExercise[key]!;
    }
    if (allExercise.containsKey(key)) {
      return exerciseData[key]!;
    }
    // Print the attributes of each exercise
    List values = [];
    for (String key in exerciseData.keys) {
      // ignore: unused_local_variable
      for (dynamic exercise in exerciseData[key]!) {
        values.add(exerciseData[key]!);
      }
    }
    return values;
  } else {
    throw Exception('Failed to load data');
  }
}
