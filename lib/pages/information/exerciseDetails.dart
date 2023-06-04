import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class ExerciseDetails extends StatelessWidget {
  final String? exerciseName;
  final String? exerciseImage;
  final String? exerciseInfo;
  final String? exerciseType;
  final String? exerciseBodyPart;
  final String? exerciseEquipment;
  final String? exerciseLevel;
  // final String? exerciseTarget;
  // final String? exerciseTips;
  // final String? exerciseRepetition;
  // final String? exerciseSets;
  const ExerciseDetails({
    Key? key,
    this.exerciseName,
    this.exerciseInfo,
    this.exerciseImage,
    this.exerciseType,
    this.exerciseBodyPart,
    this.exerciseEquipment,
    this.exerciseLevel,
    // this.exerciseTarget,
    // this.exerciseTips,
    // this.exerciseRepetition,
    // this.exerciseSets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.notifications_on, color: Colors.transparent, size: 45)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            exerciseImage ?? "can't get data",
            width: double.infinity,
            // height: MediaQuery.of(context).size.height*.3,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: titleText(
                text: exerciseName ?? "can't get data",
                color: TextColors.blackText), //$exercise name
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(
                text: exerciseInfo ?? "can't get data",
                color: TextColors.blackText,
                textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(
                text: exerciseType ?? "can't get data",
                color: TextColors.blackText,
                textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(
                text: exerciseLevel ?? "can't get data",
                color: TextColors.blackText,
                textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(
                text: exerciseEquipment ?? "can't get data",
                color: TextColors.blackText,
                textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(
                text: exerciseBodyPart ?? "can't get data",
                color: TextColors.blackText,
                textAlign: TextAlign.left), //$exercise content
          ),
        ],
      ),
    );
  }
}
