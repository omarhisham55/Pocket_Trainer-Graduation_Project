import 'package:final_packet_trainer/poseDetectionModel/poseDetection.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../navigation/cubit/cubit.dart';
import '../navigation/cubit/states.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PoseDetectionModel().initCameraController(),
        builder: (context, snapshot) {
          CameraController cameraController = snapshot.data!;
          return FutureBuilder(
              future: PoseDetectionModel().getFrames(),
              builder: (context, f) {
                print('shakalala $f');
                return BlocProvider(
                  create: (context) => CubitManager(),
                  child: BlocConsumer<CubitManager, MainStateManager>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        CubitManager cam = CubitManager.get(context);

                        CameraImage? cameraImage;
                        String output = 'output';
                        if (cameraController == null ||
                            !cameraController.value.isInitialized) {
                          return const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Scaffold(
                          body: Column(
                            children: <Widget>[
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio:
                                      cameraController.value.aspectRatio,
                                  child: CameraPreview(cameraController),
                                ),
                              ),
                              DefaultButton(
                                function: () async {
                                  if (cameraController != null &&
                                      cameraController.value.isInitialized) {
                                    // Take picture and save it to a file
                                    final image =
                                        await cameraController.takePicture();
                                    print('Image saved to ${image.path}');
                                  }
                                },
                                text: 'Take Picture',
                              ),
                            ],
                          ),
                        );
                      }),
                );
              });
        });
  }
}
