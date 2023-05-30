import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PoseDetectionModel {
  Future<void> model() async {
    final url = Uri.parse('http://$ipConnectionAddress:5000/video_frame');
    final headers = {'Content-Type': 'application/json'};
    // final data = {'scriptData': 'Data to be sent to the server'};

    final response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print('Result from the Python script: $result');
    } else {
      print('Failed to execute the Python script.');
    }
  }
}
