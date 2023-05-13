import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/components/components.dart';
import 'exerciseData.dart';

class User {
  String token;
  String name;
  String email;
  String password;
  String? urlPhoto;
  Map<String, dynamic>? nutritionPlan;
  Map<String, dynamic>? workoutPlan;

  User({
    required this.token,
    required this.name,
    required this.email,
    required this.password,
    this.urlPhoto,
    this.workoutPlan,
    this.nutritionPlan,
  });

  static User? currentUser;

  static Future<String> signUp({required String username, required String email, required String password, context}) async {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'name': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      showSnackBar(
          context: context, text: "SignUp successful welcome $username");
      toastSuccess(text: "Account created successfully");
      return response.body;
    } else if (response.statusCode == 409) {
      toastError(context: context,
          text: "Failed to create an account, ${response.body}");
      throw Exception('Failed to create account ${response.statusCode}');
    } else {
      throw Exception('Failed to create account ${response.statusCode}');
    }
  }

  static Future<void> login({required String username, required String password, required BuildContext context}) async {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/loggedin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
    ).then((value) {
      if (value.statusCode == 200) {
        final user = jsonDecode(value.body);
        print("fafa $user");
        currentUser = User(
          token: user["token"],
          name: user["name"] ?? "",
          email: user["email"] ?? "",
          password: user["password"] ?? "",
          workoutPlan: user["workoutPlan"] ?? {},
          nutritionPlan: user["NutritionPlan"] ?? {},
        );
        print("current user ${currentUser!.email}");
        showSnackBar(
            context: context, text: "Login successful welcome $username");
        toastSuccess(text: "Login successful welcome");
        print("nutrition plan of user is ${currentUser!.name}");
        print("nutrition plan of user is ${currentUser!.nutritionPlan}");
        print("exercise plan of user is ${currentUser!.workoutPlan}");
      } else {
        toastError(context: context, text: "Failed to get account");
        throw Exception('Failed to get response: ${value.statusCode}');
      }
    });
  }

  static Future<void> logout({required BuildContext context}) async {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/logout'),
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({}),
    );
    if (response.statusCode == 200) {
      print("logout successful");
      print(response.body);
      showSnackBar(context: context, text: "Logout successful");
    } else {
      toastError(context: context, text: "Logout failed");
      throw response.statusCode;
    }
  }
  // static Future<List> getProfile() async {
  //   final profile = await http.get(Uri.parse('http://$ipConnectionAddress:3000/profile'),
  //       headers: {"Authorization": "Bearer ${User.currentUser!.token}"}
  //   ).then((value) {
  //     print("value ${value.body}");
  //   });
  //   if(profile.statusCode == 200){
  //     var data = json.decode(profile.body);
  //     return data;
  //   } else{
  //     throw Exception("Failed to load data");
  //   }
  // }
}