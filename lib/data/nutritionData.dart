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
  print("meal id is $mealId");
  final response = await http.post(
    Uri.parse('http://$ipConnectionAddress:3000/add-meal-to-nutritionPlan/$mealId'),
      headers: {"Authorization": "Bearer ${User.currentUser!.token}"},
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
  print("token = ${User.currentUser!.token}");
  final meals = await http.get(
      Uri.parse('http://$ipConnectionAddress:3000/nutritionplan/breakfast'),
      headers: {"Authorization": "Bearer ${User.currentUser!.token}"}
  ).then((value){
    print("value = ${value.body}");
    print("value = ${value.statusCode}");
  }).catchError((e){
    print("error in getting breakfast $e");
  });
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    print("breakfast = $data");
    List<dynamic> breakfastData = List<dynamic>.from(data);
    return breakfastData;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}
Future<List> getLunch() async {
  print("token = ${User.currentUser!.token}");
  final meals = await http.get(
      Uri.parse('http://$ipConnectionAddress:3000/nutritionplan/lunch'),
      headers: {"Authorization": "Bearer ${User.currentUser!.token}"}
  ).then((value){
    print("value = ${value.body}");
    print("value = ${value.statusCode}");
  }).catchError((e){
    print("error in getting breakfast $e");
  });
  if(meals.statusCode == 200){
    var data = json.decode(meals.body);
    print("lunch = $data");
    List<dynamic> lunchfastData = List<dynamic>.from(data);
    return lunchfastData;
  } else{
    throw Exception("Failed to load data ${meals.statusCode}");
  }
}






Map<String, Future<List>> nutritionPageContent = {
  "breakfast": getBreakfast(),
  "snack": getBreakfast(),
  "lunch": getBreakfast(),
  "dinner": getBreakfast(),
};

Future<List> getmBreakfast()async{
  List breakfast = await Future.value([]);
  getMeals().then((value) {
    List random = generateRandomNumber(3, 1, value.length-1);
    for(var element in random){
      breakfast.add(value[element]);
    }
    // for(int i=0; i<random.length; i++){
    //   breakfast.add(value[random[i]]);
    //   print("breakfast ${breakfast.indexOf(value[random[i]])}");
    //   print("random index ${random}");
    // }
  }).catchError((e){print(e);});
  // print("object $breakfast");
  return breakfast;
}

Future<List> getNutritionHomeDataMapValues() async{
  List listValues = [];
   for(int i=0; i<nutritionPageContent.keys.length; i++){
     listValues.add([nutritionPageContent.keys.toList()[i], nutritionPageContent.values.toList()[i]]);
   }
   // print("list values $listValues");
   return listValues;
}
