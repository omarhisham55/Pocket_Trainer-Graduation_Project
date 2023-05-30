import 'dart:math';
import 'package:final_packet_trainer/shared/network/networkConnectionCheck.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'userData.dart';

class Exercise2 {
  String name;
  String image;
  String info;

  Exercise2({required this.name, required this.info, required this.image});
}

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
  // String exerciseRepetition;
  // String exerciseSets;
  // String exerciseImage;

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
    // required this.exerciseRepetition,
    // required this.exerciseSets,
    // required this.exerciseImage,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json["_id"] ?? "",
      exerciseName: json["Title"] ?? "",
      exerciseBodyPart: json["bodyPart"] ?? "",
      exerciseType: json["Type"] ?? "",
      // exerciseTarget: json["target"],
      exerciseDescription: json["Desc"] ?? "",
      exerciseLevel: json["Level"] ?? "",
      exerciseEquipment: json["Equipment"] ?? "",
      // exerciseTips: json["tips"] ?? "",
      // exerciseRepetition: json["repetition"] ?? "",
      // exerciseSets: json["sets"] ?? "",
      // exerciseImage: json["imageUrl"] ?? "",
    );
  }
}

String ipConnectionAddress = "192.168.1.5";
Future<String> ipConnectionAddress2 = getIPAddress();

//get exercises
Future<List> getChestExercises() async {
  var chestExercises = await http.get(Uri.parse('http://$ipConnectionAddress:3000/chest/exercises'));
  if (chestExercises.statusCode == 200) {
    var data = json.decode(chestExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    // ipConnectionAddress2.then((value) {
    //   print(value);
    // });
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getBackExercises() async {
  var backExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/back/exercises'));
  if (backExercises.statusCode == 200) {
    var data = json.decode(backExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getShoulderExercises() async {
  var shoulderExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/shoulder/exercises'));
  if (shoulderExercises.statusCode == 200) {
    var data = json.decode(shoulderExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getBicepsExercises() async {
  var armExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/biceps/exercises'));
  if (armExercises.statusCode == 200) {
    var data = json.decode(armExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getTricepsExercises() async {
  var armExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/triceps/exercises'));
  if (armExercises.statusCode == 200) {
    var data = json.decode(armExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getLegExercises() async {
  var legExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/leg/exercises'));
  if (legExercises.statusCode == 200) {
    var data = json.decode(legExercises.body);
    print(legExercises.statusCode);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    print(dataList.length);
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getCoreExercises() async {
  var legExercises = await http.get(Uri.parse('http://$ipConnectionAddress:3000/core/exercises'));
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
  "Biceps": getBicepsExercises(),
  "Triceps": getTricepsExercises(),
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
  } else if(key != ""){
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
      for (dynamic exercise in exerciseData[key]!) {
        values.add(exerciseData[key]!);
      }
    }
    print("exercise values $values");
    return values;
  }else{
    throw Exception('Failed to load data');
  }
}

//get stretches
class Stretches {
  String exerciseName;
  String exerciseType;
  String exerciseImage;

  // String exerciseDuration;
  String exerciseDescription;

  Stretches({
    required this.exerciseName,
    required this.exerciseType,
    required this.exerciseImage,
    // required this.exerciseDuration,
    required this.exerciseDescription,
  });

  factory Stretches.fromJson(Map<String, dynamic> json) {
    return Stretches(
      exerciseName: json["name"] ?? "",
      exerciseType: json["bodyPart"] ?? "",
      exerciseDescription: json["description"] ?? "",
      // exerciseDuration: json["duration"] ?? "",
      exerciseImage: json["imageUrl"] ?? "",
    );
  }
}

Future<List> getChestStretches() async {
  var chestExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/chest/stretches'));
  if (chestExercises.statusCode == 200) {
    var data = json.decode(chestExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();
    // ipConnectionAddress2.then((value) {
    //   print(value);
    // });
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getBackStretches() async {
  var backExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/back/stretches'));
  if (backExercises.statusCode == 200) {
    var data = json.decode(backExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getShoulderStretches() async {
  var shoulderExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/shoulder/stretches'));
  if (shoulderExercises.statusCode == 200) {
    var data = json.decode(shoulderExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getBicepsStretches() async {
  var armExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/biceps/stretches'));
  if (armExercises.statusCode == 200) {
    var data = json.decode(armExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getTricepsStretches() async {
  var armExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/triceps/stretches'));
  if (armExercises.statusCode == 200) {
    var data = json.decode(armExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getLegStretches() async {
  var legExercises = await http
      .get(Uri.parse('http://$ipConnectionAddress:3000/leg/stretches'));
  if (legExercises.statusCode == 200) {
    var data = json.decode(legExercises.body);
    final List dataList = data.map((json) => Exercise.fromJson(json)).toList();

    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Map<String, Future<List>> allStretches = {
  "Chest": getChestStretches(),
  "Back": getBackStretches(),
  "Shoulders": getShoulderStretches(),
  "Biceps": getBicepsStretches(),
  "Triceps": getTricepsStretches(),
  "Legs": getLegStretches(),
};
Map<String, List<dynamic>> stretchesData = {};

Future<List> getStretchesValues({String? key}) async {
  // Wait for all futures to complete
  for (String key in allStretches.keys) {
    stretchesData[key] = await allStretches[key]!;
  }
  print("stretches data $stretchesData");
  if (allStretches.containsKey(key)) {
    return stretchesData[key]!;
  } else {
    return Future.value([]);
  }
}

Future<List> getWorkoutPlan() async {
  var workout = await http.get(Uri.parse('http://$ipConnectionAddress:3000/workoutplan'),
      headers: {"Authorization": "Bearer ${User.token}"}
  );
  if(workout.statusCode == 200){
    var data = json.decode(workout.body);
    return data;
  } else{
    throw Exception("Failed to load data ${workout.statusCode}");
  }
}