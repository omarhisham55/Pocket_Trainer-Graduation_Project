// import 'package:final_packet_trainer/poseDetectionModel/poseDetection.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import '../main.dart';
// import '../navigation/cubit/cubit.dart';
// import '../navigation/cubit/states.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// class Camera extends StatelessWidget {
//   const Camera({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<CameraDescription>>(
//       future: availableCameras(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text(snapshot.error.toString()));
//         } else if (snapshot.hasData) {
//           final cameraController = CameraController(
//             snapshot.data![0],
//             ResolutionPreset.medium,
//           );

//           return BlocProvider(
//             create: (context) => CubitManager(),
//             child: BlocConsumer<CubitManager, MainStateManager>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 final cubitManager = CubitManager.get(context);
//                 bool isCameraOpen = false;
//                 bool isModelRunning = false;
//                 CameraImage? cameraImage;
//                 String output = 'output';
//                 final poseDetector = GoogleMlKit.vision.poseDetector();

//                 return FutureBuilder(
//                   future: PoseDetectionlala().initCameraController(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return Scaffold(
//                         body: Column(
//                           children: <Widget>[
//                             Expanded(
//                               child: AspectRatio(
//                                 aspectRatio:
//                                     cameraController.value.aspectRatio,
//                                 child: CameraPreview(cameraController),
//                               ),
//                             ),
//                             MaterialButton(
//                               onPressed: () async {
//                                 if (cameraController != null &&
//                                     cameraController.value.isInitialized) {
//                                   // Take picture and save it to a file
//                                   final image = await cameraController
//                                       .takePicture();
//                                   print('Image saved to ${image.path}');
//                                 }
//                               },
//                               child: Text('Take Picture'),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 );
//               },
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
