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

Future<List> getMeals() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meals'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}
Future<List> getMealsId() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meal/:644744c0f69324fa9a547477'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}

Future<void> addMeals({required String mealId}) async {
  final response = await http.post(
    Uri.parse('http://$ipConnectionAddress:3000/add-meal-to-nutritionPlan/$mealId'),
      headers: {"Authorization": "Bearer ${User.token}"},
    body: jsonEncode({
      "mealId": mealId
    })
  );
  if (response.statusCode == 200) {
    print('Meal added to Nutrition Plan ${response.body}');
  } else {
    throw Exception('Failed to add meal to Nutrition Plan ${response.statusCode}');
  }
}

Future<List> getBreakfast() async {
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
Future<List> getLunch() async {
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
Future<List> getDinner() async {
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