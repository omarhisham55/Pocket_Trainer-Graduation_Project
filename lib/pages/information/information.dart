import 'package:final_packet_trainer/data/exerciseData.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/information/viewExercises.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../poseDetectionModel/camera.dart';

class Information extends StatelessWidget {
  const Information({super.key});
  // List<String> exerciseType = ["Chest", "Back", "Shoulders", "Biceps", "Triceps", "Core", "Legs"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {},
        builder: (_, s) {
          CubitManager info = CubitManager.get(_);
          return Scaffold(
            appBar: notificationAppBar(context, "Information"),
            backgroundColor: BackgroundColors.background,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  future: getDataMapValues(),
                  builder: (_, snapshot) {
                    List type = [];
                    getDataMapValues().then((value) {
                      type = value;
                    }).catchError((e) {});
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemBuilder: (_, i) => DefaultButton(
                                function: () {
                                  print(type);
                                  noNavNavigator(context, const Camera());
                                  // pageNavigator(context, InformationDetails(exerciseType: type[i]));
                                },
                                text: snapshot.data![i], //$exercise name
                                height: height(context, 0.13),
                                backgroundColor: BackgroundColors.inkWellBG,
                              ),
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 10),
                          itemCount:
                              snapshot.data!.length //$number of body parts
                          );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: titleText(
                              text: "Error fetching data ${snapshot.error}"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          );
        },
      ),
    );
  }
}
