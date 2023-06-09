import 'package:camera/camera.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flython/flython.dart';

class PoseDetectionModel {
  Future<void> model() async {
    var url =
        Uri.parse('http://192.168.1.11:5000/video_feed?exercise=push-ups');
    var response = await http.get(url);
    print('azaz ${response.body}');
    /* if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('halawa $jsonResponse');
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw 'error ${response.statusCode}';
    } */
  }

  /* Future<void> openCamera() async {
    // Ensure camera availability
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print('No cameras available');
      return;
    }
    // Initialize camera
    final cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      print('lopo no e');
      // Open camera preview
      cameraController.startImageStream((image) {
      cameraController.lockCaptureOrientation();
        // Handle camera frames
      });
    }).catchError((e)=>print('lopo $e'));
  } */
}
