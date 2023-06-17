import 'package:camera/camera.dart';
import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';
// import 'package:flython/flython.dart';

class PoseDetectionModel {
  // Future<void> model() async {
  //   var url =
  //       Uri.parse('http://192.168.1.34:5000/video_feed?exercise=push-ups');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     print('halawa $jsonResponse');
  //     return jsonResponse;
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //     throw 'error ${response.statusCode}';
  //   }
  // }

  final String baseUrl = 'http://192.168.1.34:5000';
  void getVideoFeed(String exercise) async {
    print('zaza waiting for response');
    final response =
        await http.get(Uri.parse('$baseUrl/video_feed?exercise=push-ups'));
    if (response.statusCode == 200) {
      final responseData = response.body; // Retrieve response body as a string
      print('zaza $responseData');

      // Handle the response data as needed
      // ...
    } else {
      print('Request failed with status code: ${response.statusCode}');
      // Handle the response error if necessary
      // ...
    }
  }

  List frames = [];
  Future<void> getFrames() async {
    final url = 'http://192.168.1.34:5000/video_feed?exercise=push-ups';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final frameData = response.body.split('--frame');

      for (var i = 1; i < frameData.length; i++) {
        final frame = frameData[i].split('\r\n\r\n')[1];
        frames.add(frame);
        print('hala2olo $frames');
      }
    }
  }

  Future<CameraController> initCameraController() async {
    List<CameraDescription> camera = await availableCameras();
    if (camera.isNotEmpty) {
      CameraController cameraController =
          CameraController(camera[0], ResolutionPreset.ultraHigh);
      try {
        await cameraController.initialize();
      } catch (e) {
        print(e);
      }
      return cameraController;
    }
    throw 'No Camera';
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
