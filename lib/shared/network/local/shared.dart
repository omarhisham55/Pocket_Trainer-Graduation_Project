import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Saving the list
void saveList(List<dynamic> requirements) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = jsonEncode(requirements);
  prefs.setString('requirements', jsonList);
}

// Retrieving the list
Future<List<dynamic>> getList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = prefs.getString('requirements')!;
  if (jsonList.isNotEmpty) {
    return List<dynamic>.from(jsonDecode(jsonList));
  }
  return [];
}

void updateAllList(List<dynamic> requirements) {
  // Get the list from SharedPreferences
  List<dynamic> updatedRequirements = [];
  for (dynamic requirement in requirements) {
    updatedRequirements.add(requirement);
  }

  // Save the list to SharedPreferences
  saveList(updatedRequirements);
}

clearList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  debugPrint(prefs.getString('requirements'));
}
