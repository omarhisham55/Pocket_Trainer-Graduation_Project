import 'package:dashboard/bloc/cubit.dart';
import 'package:dashboard/bloc/states.dart';
import 'package:dashboard/components/colors.dart';
import 'package:dashboard/components/components.dart';
import 'package:dashboard/components/constants.dart';
import 'package:dashboard/components/new_components.dart';
import 'package:dashboard/data/exercise_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataMapValues(allValues: true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => DashboardManager(),
              child: BlocConsumer<DashboardManager, DashboardState>(
                  listener: (_, s) {},
                  builder: (_, s) {
                    DashboardManager profile = DashboardManager().get(_);
                    Map<String, dynamic> cards = {
                      'Home': {
                        'icon': const Icon(Icons.account_circle,
                            color: Colors.grey, size: 35.0),
                        'name': 'Total users',
                        'total': 0,
                        'color': BackgroundColors.blueGradient
                      },
                      'Gym': {
                        'icon': Image.asset('images/gymIcon.png', width: 40.0),
                        'name': 'Total exercises',
                        'total': snapshot.data!.length,
                        'color': BackgroundColors.greenGradient
                      },
                      'Nutrition': {
                        'icon': Image.asset('images/nutritionIcon.png',
                            width: 40.0),
                        'name': 'Total users',
                        'total': 0,
                        'color': BackgroundColors.redGradient
                      },
                    };
                    final List<Map> data = [
                      {'ID': '1', 'Name': 'John Doe', 'Age': '25'},
                      {'ID': '2', 'Name': 'Jane Smith', 'Age': '30'},
                      {'ID': '3', 'Name': 'Bob Johnson', 'Age': '35'},
                    ];
                    var cardValues = cards.values.toList();
                    return Container(
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 160,
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, i) => dashboardCard(
                                    context: context,
                                    icon: cardValues[i]['icon'],
                                    nameTotal: cardValues[i]['name'],
                                    total: cardValues[i]['total'],
                                    backgroundColorGradient: cardValues[i]
                                        ['color']),
                                separatorBuilder: (_, i) =>
                                    const SizedBox(width: 50.0),
                                itemCount: 3),
                          ),
                          databaseTable(context, data)
                        ],
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: titleText(
                    text: "Error fetching data ${snapshot.error}",
                    color: TextColors.blackText));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget userCard(
          {required BuildContext context,
          required Widget icon,
          required String name,
          required int total,
          required LinearGradient color}) =>
      dashboardCard(
          context: context,
          icon: icon,
          nameTotal: name,
          total: total,
          backgroundColorGradient: color);
}
