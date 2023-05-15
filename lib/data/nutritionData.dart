import 'package:final_packet_trainer/data/userData.dart';

import 'exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionData {
  String id;
  String name;
  String calories;
  String protein;
  String fats;
  String carbs;
  String quantity;
  String image;
  String typeofMeal;

  NutritionData({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.quantity,
    required this.image,
    required this.typeofMeal,
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
        id: json["_id"].toString() ?? "",
        name: json["name"] ?? "",
        calories: json["calories"] ?? "",
        protein: json["protein"] ?? "",
        carbs: json["carbs"] ?? "",
        fats: json["fats"] ?? "",
        quantity: json["quantity"] ?? "",
        image: json["imageUrl"] ?? "",
        typeofMeal: json["typeofMeal"] ?? "",
    );
  }
}

Future<List> getBreakfast() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meals/breakfast'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}
Future<List> getLunch() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meals/lunch'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}
Future<List> getDinner() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meals/dinner'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}

Map<String, Future<List>> allMeals = {
  "breakfast": getBreakfast(),
  "lunch": getLunch(),
  "dinner": getDinner()
};
Map<String, List<dynamic>> nutritionData = {};

Future<List> getNutritionData({required key}) async{
  for (String key in allMeals.keys) {
    nutritionData[key] = await allMeals[key]!;
  }
  if (allMeals.containsKey(key)) {
    return nutritionData[key]!;
  }
  List values = [];
  for (String key in nutritionData.keys) {
    for (dynamic meal in nutritionData[key]!) {
      values.add(nutritionData[key]!);
    }
  }
  print("nutrition values $values");
  return values;
}


Future<List> getBreakfastNutritionPlan() async {
  final meals = await http.get(
      Uri.parse('http://$ipConnectionAddress:3000/nutritionplan/breakfast'),
      headers: {"Authorization": "Bearer ${User.token}"}
  ).catchError((e){throw e;});
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    return data;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}
Future<List> getLunchNutritionPlan() async {
  final meals = await http.get(
      Uri.parse('http://$ipConnectionAddress:3000/nutritionplan/lunch'),
      headers: {"Authorization": "Bearer ${User.token}"}
  ).catchError((e){throw e;});
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    return data;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}
Future<List> getDinnerNutritionPlan() async {
  final meals = await http.get(
      Uri.parse('http://$ipConnectionAddress:3000/nutritionplan/dinner'),
      headers: {"Authorization": "Bearer ${User.token}"}
  ).catchError((e){throw e;});
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    return data;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}