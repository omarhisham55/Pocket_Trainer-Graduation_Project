import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/images.dart';

class ExerciseDetails extends StatelessWidget {
  final String exerciseName;
  final String exerciseImage;
  final String exerciseInfo;
  final String exerciseType;
  final String exerciseTarget;
  final String exerciseTips;
  // final String exerciseRepetition;
  // final String exerciseSets;
  const ExerciseDetails({Key? key,
    required this.exerciseName,
    required this.exerciseInfo,
    required this.exerciseImage,
    required this.exerciseType,
    required this.exerciseTarget,
    required this.exerciseTips,
    // required this.exerciseRepetition,
    // required this.exerciseSets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: const [Icon(Icons.notifications_on, color: Colors.transparent, size: 45)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            exerciseImage,
            width: double.infinity,
            // height: MediaQuery.of(context).size.height*.3,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: titleText(text: exerciseName, color: TextColors.blackText), //$exercise name
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(text: exerciseInfo, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(text: exerciseType, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(text: exerciseTarget, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: paragraphText(text: exerciseTips, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: paragraphText(text: exerciseRepetition, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: paragraphText(text: exerciseSets, color: TextColors.blackText, textAlign: TextAlign.left), //$exercise content
          // ),
        ],
      ),
    );
  }
}
