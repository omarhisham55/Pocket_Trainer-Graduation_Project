import 'package:dashboard/bloc/cubit.dart';
import 'package:dashboard/bloc/states.dart';
import 'package:dashboard/components/constants.dart';
import 'package:dashboard/pages/exercises.dart';
import 'package:dashboard/pages/nutrition.dart';
import 'package:dashboard/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DashboardManager(),
        child: BlocConsumer<DashboardManager, DashboardState>(
            listener: (_, s) {},
            builder: (_, s) {
              DashboardManager home = DashboardManager().get(_);
              StatelessWidget getPage(int index) {
                switch (index) {
                  case 0:
                    return const Profile();
                  case 1:
                    return const Exercises();
                  case 2:
                    return const Nutrition();
                  default:
                    return Container();
                }
              }

              return Scaffold(
                body: Row(
                  children: [
                    //side menu
                    NavigationRail(
                      selectedIndex: home.selectedIndex,
                      onDestinationSelected: home.changeMenu,
                      labelType: NavigationRailLabelType.none,
                      extended: home.isExpanded,
                      destinations: [
                        const NavigationRailDestination(
                          icon: Icon(Icons.account_circle,
                              color: Colors.grey, size: 35.0),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset('images/gymIcon.png', width: 40.0),
                          label: const Text('Exercises'),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset('images/nutritionIcon.png',
                              width: 40.0),
                          label: const Text('Nutrition'),
                        ),
                        const NavigationRailDestination(
                          icon: Icon(Icons.settings, size: 35.0),
                          label: Text('Settings'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    //actual page
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                home.openMenu();
                                home.changePageWidth(context);
                              },
                              icon: const Icon(Icons.menu)),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                constraints:
                                    BoxConstraints(maxWidth: width(context, .9)),
                                width: home.pageWidth,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: getPage(home.selectedIndex))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
