import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/nutrition_dialog_data.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'food_details.dart';

import 'package:roundcheckbox/roundcheckbox.dart';

class ChooseFood extends StatelessWidget {
  List selectedMeals;
  String typeofMeal;

  ChooseFood({super.key, required this.selectedMeals, required this.typeofMeal});

  Set cloneList = {};

  @override
  Widget build(BuildContext context) {
    List searchList = [];
    getNutritionData(key: typeofMeal).then((value) {
      searchList = value;
      // print("first search list $searchList");
    }).catchError((e) {});
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {
          if (s is ChangeSearchState) {
            searchList = s.filteredList;
          }
        },
        builder: (_, s) {
          CubitManager nutrition = CubitManager.get(_);
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      selectedMeals = [];
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)
                ),
                centerTitle: true,
                title: (nutrition.isSearchOpened)
                    ? TextField(
                        controller: nutrition.searchQuery,
                        style: const TextStyle(
                          color: BackgroundColors.whiteBG,
                        ),
                        decoration: const InputDecoration(
                            hintText: "Search here..",
                            hintStyle: TextStyle(color: Colors.white)),
                      )
                    : titleText(text: "Add Food"),
                backgroundColor: BackgroundColors.dialogBG,
                actions: <Widget>[
                  IconButton(
                    icon: (nutrition.isSearchOpened)
                        ? const Icon(
                            Icons.close,
                            color: BackgroundColors.whiteBG,
                          )
                        : const Icon(Icons.search,
                            color: BackgroundColors.whiteBG),
                    onPressed: () {
                      nutrition.changeSearchIcon(searchList: searchList);
                      if (!nutrition.isSearchOpened) {
                        nutrition.searchQuery.clear();
                      }
                      nutrition.searchQueryMealListener(searchList);
                    },
                  ),
                ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: getBreakfast(),
                  builder: (_, snapshot) {
                    print('nomk ${searchList.length}');
                    if (snapshot.hasData) {
                      return (snapshot.data!.isEmpty)
                          ? Center(
                              child: titleText(text: "No meals found"),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => TextButton(
                                    onPressed: () {
                                      navNavigator(
                                          context,
                                          FoodDetails(
                                            title: searchList[index].name,
                                            calories:
                                                searchList[index].calories,
                                            carbs: searchList[index].carbs,
                                            fats: searchList[index].fats,
                                            protein: searchList[index].protein,
                                            quantity:
                                                searchList[index].quantity,
                                            image: searchList[index].image,
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        RoundCheckBox(
                                          onTap: (selected) {
                                            if (selected!) {
                                              selectedMeals.add(searchList[index]);
                                            } else {
                                              selectedMeals.remove(searchList[index]);
                                            }
                                            cloneList = Set.from(selectedMeals);
                                            print("selectedMeals in time $selectedMeals");
                                            print("clone Meals in time $cloneList");
                                          },
                                          size: 25,
                                        ),
                                        const SizedBox(width: 10),
                                        subTitleText(
                                            text: searchList[index].name,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            width: width(context, .7),
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            textOverflow: TextOverflow.ellipsis)
                                      ],
                                    ),
                                  ),
                              separatorBuilder: (context, index) => const Divider(),
                          itemCount: searchList.length);
                    } else if (snapshot.hasError) {
                      return Center(
                          child: titleText(
                              text: "Error fetching data ${snapshot.error}"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButton(
                    function: () {
                      print("returning ${cloneList.toList()}");
                      Navigator.of(context).pop(cloneList.toList());
                    },
                    borderRadius: 30,
                    text: "Add",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
