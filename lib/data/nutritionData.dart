import 'package:final_packet_trainer/data/userData.dart';

import 'exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionData {
  String id;
  String name;
  int breakfast;
  int lunch;
  int dinner;
  int isVegan;
  num calories;
  num protein;
  num fats;
  num iron;
  num calcium;
  num sodium;
  num potassium;
  num carbs;
  num fiber;
  num vitaminD;
  num sugar;
  String image;
  String ingredients;

  NutritionData({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.breakfast,
    required this.fats,
    required this.lunch,
    required this.dinner,
    required this.isVegan,
    required this.calcium,
    required this.sodium,
    required this.potassium,
    required this.iron,
    required this.carbs,
    required this.fiber,
    required this.vitaminD,
    required this.sugar,
    required this.image,
    required this.ingredients
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      id: json["_id"].toString(),
      name: json["Food_items"].toString(),
      breakfast: json["Breakfast"],
      lunch: json["Lunch"],
      dinner: json["Dinner"],
      isVegan: json["VegNovVeg"],
      calories: json["Calories"],
      protein: json["Proteins"],
      fats: json["Fats"],
      iron: json["Iron"],
      calcium: json["Calcium"],
      sodium: json["Sodium"],
      potassium: json["Potassium"],
      carbs: json["Carbohydrates"],
      fiber: json["Fibre"],
      vitaminD: json["VitaminD"],
      sugar: json["Sugars"],
      image: json["imageUrl"].toString(),
      ingredients: json["Ingredients"].toString()
    );
  }
}

Future<List> getBreakfast() async {
  var meals = await http.get(Uri.parse('$url/meals/breakfast'));
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    var mealsDataList =
        data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else {
    throw Exception("Failed to load data");
  }
}

Future<List> getLunch() async {
  var meals = await http.get(Uri.parse('$url/meals/lunch'));
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    var mealsDataList =
        data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else {
    throw Exception("Failed to load data");
  }
}

Future<List> getDinner() async {
  var meals = await http.get(Uri.parse('$url/meals/dinner'));
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    var mealsDataList =
        data.map((json) => NutritionData.fromJson(json)).toList();
    return mealsDataList;
  } else {
    throw Exception("Failed to load data");
  }
}

Map<String, Future<List>> allMeals = {
  "breakfast": getBreakfast(),
  "lunch": getLunch(),
  "dinner": getDinner()
};
Map<String, List<dynamic>> nutritionData = {};

Future<List> getNutritionData({required key}) async {
  for (String key in allMeals.keys) {
    nutritionData[key] = await allMeals[key]!;
  }
  if (allMeals.containsKey(key)) {
    return nutritionData[key]!;
  }
  List values = [];
  for (String key in nutritionData.keys) {
    // ignore: unused_local_variable
    for (dynamic meal in nutritionData[key]!) {
      values.add(nutritionData[key]!);
    }
  }
  return values;
}

Future<List> getBreakfastNutritionPlan() async {
  final meals = await http.get(Uri.parse('$url/nutritionplan/breakfast'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Access-Control-Allow-Origin": "$url/*"
      }).catchError((e) {
    throw e;
  });
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    return data;
  } else {
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}

Future<List> getLunchNutritionPlan() async {
  final meals = await http.get(Uri.parse('$url/nutritionplan/lunch'), headers: {
    "Authorization": "Bearer ${User.token}",
    "Access-Control-Allow-Origin": "$url/*"
  }).catchError((e) {
    throw e;
  });
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    return data;
  } else {
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}

Future<List> getDinnerNutritionPlan() async {
  final meals = await http.get(Uri.parse('$url/nutritionplan/dinner'),
      headers: {
        "Authorization": "Bearer ${User.token}",
        "Access-Control-Allow-Origin": "$url/*"
      }).catchError((e) {
    throw e;
  });
  if (meals.statusCode == 200) {
    var data = json.decode(meals.body);
    return data;
  } else {
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}
