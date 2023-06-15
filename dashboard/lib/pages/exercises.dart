import 'package:dashboard/bloc/cubit.dart';
import 'package:dashboard/bloc/states.dart';
import 'package:dashboard/components/constants.dart';
import 'package:dashboard/components/new_components.dart';
import 'package:dashboard/data/exercise_data.dart';
import 'package:dashboard/storage/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/colors.dart';
import '../components/components.dart';

class Exercises extends StatelessWidget {
  const Exercises({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardManager(),
      child: BlocConsumer<DashboardManager, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<DataColumn> buildExerciesColumns(List<Exercise> data) {
            return data.isNotEmpty
                ? [
                    DataColumn(
                        label:
                            titleText(text: 'id', color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Name',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise BodyPart',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Type',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Description',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Level',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Equipment',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Repetition',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Sets',
                            color: TextColors.blackText)),
                    DataColumn(
                        label: titleText(
                            text: 'exercise Image',
                            color: TextColors.blackText)),
                  ]
                : [];
          }

          List<DataRow> buildExerciseRows(List<Exercise> data) {
            return data.map((row) {
              return DataRow(cells: [
                DataCell(subTitleText(
                    text: row.exerciseId.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseName.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseBodyPart.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseType.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseDescription.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseLevel.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseEquipment.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseRepetition.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseSets.toString(),
                    color: TextColors.blackText)),
                DataCell(subTitleText(
                    text: row.exerciseImage.toString(),
                    color: TextColors.blackText)),
              ]);
            }).toList();
          }

          return FutureBuilder(
              future: getExerciseData(),
              builder: (context, snapshot) {
                if(snapshot.data!.isEmpty){
                  getDataMapValues(allValues: true).then((value) => saveExerciseData(value));
                }
                if (snapshot.hasData) {
                  List<Future<Exercise>> exerciseData = snapshot.data!.cast<Future<Exercise>>();
                  return DataTable(
                    columns: buildExerciesColumns(exerciseData.cast<Exercise>()),
                    rows: buildExerciseRows(exerciseData.cast<Exercise>()),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: titleText(
                          text: "Error fetching data ${snapshot.error}",
                          color: TextColors.blackText));
                } else {
                  return Center(
                      child: Column(
                    children: [
                      const CircularProgressIndicator(
                          color: BackgroundColors.blackBG),
                      paragraphText(
                          text: 'loading...', color: TextColors.blackText)
                    ],
                  ));
                }
              });
        },
      ),
    );
  }
}
