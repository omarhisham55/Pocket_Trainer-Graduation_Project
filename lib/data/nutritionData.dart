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
    return mealsDataList;
  } else{
    throw Exception("Failed to load data");
  }
}

Map<String, Future<List>> nutritionPageContent = {
  "breakfast": getBreakfast(),
  "snack": getBreakfast(),
  "lunch": getBreakfast(),
  "dinner": getBreakfast(),
};

Future<List> getBreakfast()async{
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
  print("object $breakfast");
  return breakfast;
}
Map<String, List> nutritionPageContentCheck = {};

Future<List> getNutritionHomeDataMapValues() async{
  List listValues = [];
   for(var keys in nutritionPageContent.keys){
     nutritionPageContentCheck[keys] = await nutritionPageContent[keys]!;
   }
   print("original map content $nutritionPageContent");
   print("new map content $nutritionPageContentCheck");
   for(var keys in nutritionPageContentCheck.keys){
     listValues.addAll([nutritionPageContentCheck[keys]]);
   }
   print("list values $listValues");
   return listValues;
}
