// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/components/components.dart';
import 'exerciseData.dart';

class User {
  String? name;
  String? email;
  String? password;
  // String? urlPhoto;
  Map<String, dynamic>? nutritionPlan;
  Map<String, dynamic>? workoutPlan;

  User({
    this.name,
    this.email,
    this.password,
    // this.urlPhoto,
    this.workoutPlan,
    this.nutritionPlan,
  });

  static var token;
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
      showSnackBar(context: context, text: "SignUp successful welcome $username");
      toastSuccess(context: context, text: "Account created successfully");
      return response.body;
    } else if (response.statusCode == 409) {
      toastError(context: context, text: "Failed to create an account, ${response.body}");
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
        token = user["token"];
        getProfile();
      } else {
        toastError(context: context, text: value.body);
        throw Exception('Failed to get response: ${value.statusCode}');
      }
    });
  }

  static Future<void> logout({required BuildContext context}) async {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/logout'),
      headers: {"Authorization": "Bearer ${User.token}"},
      // body: jsonEncode({}),
    );
    if (response.statusCode == 200) {
      print("logout successful");
      print(response.body);
      toastSuccess(context: context, text: "Logout successful");
    } else {
      toastError(context: context, text: "Logout failed ${response.statusCode} ${response.body}");
    }
  }
  static Future<Map<String, dynamic>> getProfile() async {
    final profile = await http.get(Uri.parse('http://$ipConnectionAddress:3000/profile'),
        headers: {"Authorization": "Bearer ${User.token}"}
    );
    if(profile.statusCode == 200){
      var user = json.decode(profile.body);
      currentUser = User(
        name: user["name"] ?? "",
        email: user["email"] ?? "",
        password: user["password"] ?? "",
        // urlPhoto: user["photo"] ?? "",
        workoutPlan: user["workoutPlan"] ?? {},
        nutritionPlan: user["NutritionPlan"] ?? {},
      );
      return user;
    } else{
      throw Exception("Failed to load data");
    }
  }
}