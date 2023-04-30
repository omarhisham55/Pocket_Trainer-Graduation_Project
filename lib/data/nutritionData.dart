import 'exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionData {
  String name;
  String calories;
  String protein;
  String fats;
  String carbs;
  String quantity;
  String image;

  NutritionData({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.quantity,
    required this.image,
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
        name: json["name"] ?? "",
        calories: json["calories"] ?? "",
        protein: json["protein"] ?? "",
        carbs: json["carbs"] ?? "",
        fats: json["fats"] ?? "",
        quantity: json["quantity"] ?? "",
        image: json["imageUrl"] ?? "");
  }
}

Future<List> getMeals() async {
  var meals = await http.get(Uri.parse('http://$ipConnectionAddress:3000/meals'));
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    var mealsDataList = data.map((json) => NutritionData.fromJson(json)).toList();
    print(mealsDataList);
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}