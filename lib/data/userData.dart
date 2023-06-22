// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../shared/components/components.dart';
import 'exerciseData.dart';

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.urlPhotoData,
      this.urlPhotoContent,
      this.workoutPlan,
      this.nutritionPlan,
      this.requirements});

  static User? currentUser;
  // ignore: prefer_typing_uninitialized_variables
  static var token;
  static var tempToken;

  String? id;
  String? email;
  String? name;
  Map<String, dynamic>? nutritionPlan;
  String? password;
  String? urlPhotoContent;
  String? urlPhotoData;
  Map<String, dynamic>? workoutPlan;
  Map<String, dynamic>? requirements;

  static Future<String> signUp({
    required String username,
    required String email,
    required String password,
    File? imageData,
    context,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$url/signup'));
    request.fields['name'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;
    if (imageData != null) {
      request.files
          .add(await http.MultipartFile.fromPath('photo', imageData.path));
    }
    final response = await request.send();
    if (response.statusCode == 201) {
      toastSuccess(context: context, text: response.reasonPhrase!);
      return response.reasonPhrase!;
    } else if (response.statusCode == 409) {
      toastWarning(context: context, text: response.reasonPhrase!);
      throw Exception('Failed to create account ${response.statusCode}');
    } else {
      toastError(
          context: context,
          text: "Failed to create an account, ${response.reasonPhrase}");
      throw Exception('Failed to create an account ${response.statusCode}');
    }
  }

  static Future<void> login({
    required String username,
    required String password,
    required BuildContext context,
    required blocContest,
  }) async {
    // ignore: unused_local_variable
    final response = await http
        .post(
      Uri.parse('$url/loggedin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final user = jsonDecode(value.body);
        token = user["token"];
        print(token);
        CubitManager.get(blocContest).getProfile(context).then((value) {
          print(value['NutritionPlan']);
          CubitManager.get(blocContest).changeGymToNotEmpty();
          CubitManager.get(blocContest).changeNutToNotEmpty();
        });
      } else {
        toastError(context: context, text: value.body);
        throw Exception('Failed to get response: ${value.statusCode}');
      }
    });
  }

  // Future<Map<String, dynamic>> getProfile() async {
  //   final profile = await http.get(Uri.parse('$url/profile'),
  //       headers: {"Authorization": "Bearer ${User.token}"});
  //   if (profile.statusCode == 200) {
  //     var user = json.decode(profile.body);
  //     currentUser = User(
  //       id: user['_id'] ?? "",
  //       name: user["name"] ?? "",
  //       email: user["email"] ?? "",
  //       password: user["password"] ?? "",
  //       urlPhotoData: user["photo"] != null && user["photo"]["data"] != null
  //           ? user["photo"]["data"]["data"].toString()
  //           : null.toString(),
  //       workoutPlan: user["workoutPlan"] ?? {},
  //       nutritionPlan: user["NutritionPlan"] ?? {},
  //       requirements: user['ListOfRequirment'] ?? [],
  //     );
  //     print(user);
  //     print(currentUser);
  //     return user;
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }

  static Future deleteProfile(context) async {
    final profile =
        await http.delete(Uri.parse('$url/delete/profile'), headers: {
      "Authorization": "Bearer ${User.token}",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "$url/*"
    });
    if (profile.statusCode != 200) {
      toastError(
          context: context, text: "${profile.body} ${profile.statusCode}");
    } else {
      toastDelete(
          context: context, text: "${profile.body} ${profile.statusCode}");
    }
  }

  static Future forgetPassword(
      {required BuildContext context, required String email}) async {
    var forget = await http.patch(Uri.parse('$url/forget/password'),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "$url/*"
        },
        body: jsonEncode({'email': email}));
    if (forget.statusCode != 200) {
      toastError(context: context, text: jsonDecode(forget.body)['status']);
    } else {
      tempToken = jsonDecode(forget.body)['token'];
    }
  }

  static Future resetPassword(
      {required BuildContext context,
      required String tempToken,
      required String password}) async {
    var reset = await http.patch(Uri.parse('$url/reset/password/$tempToken'),
        headers: {
          "Authorization": "Bearer ${User.tempToken}",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "$url/*"
        },
        body: jsonEncode({'password': password}));

    print(password);
    print(tempToken);
    if (reset.statusCode != 200) {
      toastError(context: context, text: jsonDecode(reset.body)['message']);
    } else {
      toastSuccess(context: context, text: 'Password changed');
    }
  }

  static Future<File?> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      // List<int>? imageBytes = await imageFile.readAsBytes();
      return imageFile;
    }

    return null;
  }
}
