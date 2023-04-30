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
  int? addedFood;
  List? addedFoodList;
  ChooseFood({super.key, this.addedFood, this.addedFoodList});

  @override
  Widget build(BuildContext context) {
    List searchList = [];
    getMeals().then((value) {
      searchList = value;
      print("first search list $searchList");
    }).catchError((e) {});
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {
          if(s is ChangeSearchState){
            searchList = s.filteredList;
          }
        },
        builder: (_, s) {
          CubitManager foodChangeable = CubitManager.get(_);
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: (foodChangeable.isSearchOpened)
                    ? TextField(
                        controller: foodChangeable.searchQuery,
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
                    icon: (foodChangeable.isSearchOpened)
                        ? const Icon(
                            Icons.close,
                            color: BackgroundColors.whiteBG,
                          )
                        : const Icon(Icons.search,
                            color: BackgroundColors.whiteBG),
                    onPressed: () {
                      foodChangeable.changeSearchIcon(searchList: searchList);
                      if (!foodChangeable.isSearchOpened) foodChangeable.searchQuery.clear();
                      foodChangeable.searchQueryMealListener(searchList);
                    },
                  ),
                ]
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: getMeals(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data!.isEmpty)
                          ? Center(
                              child: titleText(text: "No meals found"),
                            )
                          : ListView.separated(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => TextButton(
                                    onPressed: () {
                                      navNavigator(
                                          context,
                                          FoodDetails(
                                            title: snapshot.data![index].name,
                                            calories: snapshot.data![index].calories,
                                            carbs: snapshot.data![index].carbs,
                                            fats: snapshot.data![index].fats,
                                            protein: snapshot.data![index].protein,
                                            quantity: snapshot.data![index].quantity,
                                            image: snapshot.data![index].image,
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        RoundCheckBox(
                                            onTap: (selected) {
                                              // (selected!) ? selectedFood.add(foodTitle.elementAt(index))
                                              //     : selectedFood.remove(foodTitle.elementAt(index));
                                              // widget.addedFood = selectedFood.length;
                                              // print(widget.addedFood);
                                              // print(selectedFood);
                                            },
                                            size: 25),
                                        const SizedBox(width: 20),
                                        subTitleText(
                                            text: searchList[index].name,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 2,
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
                        // Navigator.of(context).pop(selectedFood);
                        // print(selectedFood.length);
                        // print(selectedFood);
                      },
                      borderRadius: 30,
                      text: "Add"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
