import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/components/components.dart';
import 'exerciseData.dart';

class User {
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

Future<List> signUp({String? username, String? email, String? password, context}) async {
  try {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'name': username!,
        'email': email!,
        'password': password!,
      }),
    );
    if(response.statusCode == 201) {
        var user = jsonDecode(response.body);
        toastSuccess(text: "Account created successfully");
        return user;
    }else if(response.statusCode == 409){
      toastError(context: context,text: "Failed to create an account ${response.body}");
      throw Exception('');
    }else{
      throw Exception('Failed to create account ${response.statusCode}');
    }
  } catch (e) {
    toastError(context: context,text: "signUp failed data failed to go to server ");
    throw Exception('Failed to signUp: $e');
  }
}

Future<List> login({String? username, String? password, context}) async {
  try {
    final response = await http.post(
      Uri.parse('http://$ipConnectionAddress:3000/loggedin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': username!,
        'password': password!,
      }),
    );
    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      toastSuccess(text: "Login successful welcome");
      return user;
    } else {
      toastError(context: context,text: "Failed to get account");
      throw Exception('Failed to get response: ${response.statusCode}');
    }
  } catch (e) {
    toastError(context: context,text: "Login failed data failed to go to server");
    throw Exception('Failed to login: $e');
  }
}
