import 'package:dashboard/components/colors.dart';
import 'package:dashboard/components/components.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget dashboardCard(
        {required BuildContext context,
        required Widget icon,
        required String nameTotal,
        required int total,
        LinearGradient? backgroundColorGradient}) =>
    Container(
      width: width(context, .15),
      decoration: BoxDecoration(
          gradient: backgroundColorGradient,
          borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          titleText(text: nameTotal, color: TextColors.blackText),
          subTitleText(text: total.toString(), color: TextColors.blackText)
        ],
      ),
    );

Widget databaseTable(
  context,
  List<Map> data,
) =>
    SizedBox(
      width: width(context, 1),
      child: DataTable(
        columns: buildColumns(data).cast<DataColumn>(),
        rows: buildRows(data).cast<DataRow>(),
      ),
    );
List buildColumns(List<Map> data) {
  return data.isNotEmpty
      ? data.first.keys
          .map((key) => DataColumn(
              label: titleText(text: key, color: TextColors.blackText)))
          .toList()
      : [];
}

List buildRows(List<Map> data) {
  return data.map((row) {
    return DataRow(
      cells: row.values
          .map((value) => DataCell(subTitleText(
              text: value.toString(), color: TextColors.blackText)))
          .cast<DataCell>()
          .toList(),
    );
  }).toList();
}
