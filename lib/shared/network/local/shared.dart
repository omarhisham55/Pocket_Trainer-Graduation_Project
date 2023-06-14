import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Saving the list
void saveList(List<dynamic> requirements) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
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
