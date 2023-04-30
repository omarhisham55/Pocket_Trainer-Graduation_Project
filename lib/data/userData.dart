import 'package:http/http.dart' as http;
import 'dart:convert';

import 'exerciseData.dart';

class User{
  String name;
  String email;
  String password;
  String? urlPhoto;
  User({
    required this.name,
    required this.email,
    required this.password,
    this.urlPhoto,
});
}

Future<List> login({String? username, String? password}) async {
  final response = await http.post(Uri.parse('http://$ipConnectionAddress:3000/loggedin'),
    body: jsonEncode(<String, String>{
      'email': username ?? "",
      'password': password ?? "",
    }),
  );

  if (response.statusCode == 200) {
    final user = jsonDecode(response.body);
    print('login success \n $username \n $password');
    return user;
    // Store the token in shared preferences or local storage
  } else {
    throw Exception('Failed to login');
  }
}