import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/information/exerciseDetails.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:final_packet_trainer/shared/styles/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/exerciseData.dart';

class InformationDetails extends StatelessWidget {
  final String exerciseType;
  InformationDetails({Key? key, required this.exerciseType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List searchImage = [];
    List searchList = [];
    getDataMapValues(key: exerciseType, allValues: false).then((value) {
      searchList = value;
      print("first search list exercise $searchList");
    }).catchError((e){});
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s){
          if(s is ChangeSearchState){
            searchList = s.filteredList;
          }
        },
        builder: (_, s){
          CubitManager infoData = CubitManager.get(_);
          return SafeArea(
              child: Scaffold(
                  backgroundColor: BackgroundColors.background,
                  appBar: AppBar(
                      centerTitle: true,
                      title: (infoData.isSearchOpened)
                          ? TextField(
                        controller: infoData.searchQuery,
                        style: const TextStyle(
                          color: BackgroundColors.whiteBG,
                        ),
                        decoration: const InputDecoration(
                            hintText: "Search here..",
                            hintStyle: TextStyle(color: Colors.white)),
                      )
                          : titleText(text: exerciseType),
                      backgroundColor: BackgroundColors.dialogBG,
                      actions: <Widget>[
                        IconButton(
                          icon: (infoData.isSearchOpened)
                              ? const Icon(
                            Icons.close,
                            color: BackgroundColors.whiteBG,
                          )
                              : const Icon(Icons.search,
                              color: BackgroundColors.whiteBG),
                          onPressed: () {
                            infoData.changeSearchIcon(searchList: searchList);
                            if (!infoData.isSearchOpened) infoData.searchQuery.clear();
                            infoData.searchQueryExerciseListener(searchList);
                          },
                        ),
                      ]
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FutureBuilder(
                        future: getDataMapValues(key: exerciseType),
                        builder: (_, snapshot) {
                            return AlignedGridView.count(
                              itemCount: searchList.length, //$exercise number
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              itemBuilder: (_, i) {
                                return exerciseCard(
                                  function: () {
                                    pageNavigator(
                                        context,
                                        ExerciseDetails(
                                          exerciseName: snapshot.data![i].exerciseName,
                                          exerciseInfo: snapshot.data![i].exerciseDescription,
                                          exerciseImage: snapshot.data![i].exerciseImage,
                                          exerciseType: snapshot.data![i].exerciseType,
                                          exerciseTarget: snapshot.data![i].exerciseTarget,
                                          exerciseTips: snapshot.data![i].exerciseTips,
                                          // exerciseRepetition: snapshot.data![i].exerciseRepetition,
                                          // exerciseSets: snapshot.data![i].exerciseSets,
                                        ));
                                  },
                                  image: searchList[i]!.exerciseImage,
                                  title: searchList[i].exerciseName, //$exercise name
                                  width: width(context, .5)
                                );
                              }
                            );
                        }
                    ),
                  )
              ),
            );
        },
      ),
    );
  }
}