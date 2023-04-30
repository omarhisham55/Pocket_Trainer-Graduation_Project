import 'package:circle_button/circle_button.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/images.dart';
import 'food_selection.dart';

class NutritionHome extends StatelessWidget {
  const NutritionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
          listener: (_, s) {},
          builder: (_, s) {
            CubitManager nutrition = CubitManager.get(_);
            return Scaffold(
              backgroundColor: BackgroundColors.background,
              body: SlidingUpPanel(
                maxHeight: height(context, .4),
                minHeight: 0.0,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                //SlideUp panel for show food list when blue button appears
                panelBuilder: (scrollController) => SlidingUpPanel(
                    controller: nutrition.foodListPanel,
                    maxHeight: height(context, .3),
                    minHeight: 0.0,
                    body: Stack(alignment: Alignment.topRight, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () => nutrition.foodListPanel.close(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                                child: titleText(
                                    text: "Add Meal",
                                    color: TextColors.blackText,
                                    textAlign: TextAlign.start),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black54)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultDropDownMenu(
                                          content: [],
                                          hintValue: nutrition.selectedValue,
                                          function: (value) {
                                            nutrition.dropDownSelect(value, nutrition.selectedValue);
                                          })),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                //select meal button
                                child: DefaultButton(
                                    function: () async {
                                      // navNavigator(context, ChooseFood(addedFood: addNumber, addedFoodList: addFood));
                                      // final result = await Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ChooseFood(
                                      //         addedFood: nutrition.addNumber,
                                      //         addedFoodList: []),
                                      //   ),
                                      // );
                                      // setState(() {
                                      //   addFood = result;
                                      //   addNumber = addFood.length;
                                      // });
                                    },
                                    backgroundColor: BackgroundColors.whiteBG,
                                    width: MediaQuery.of(context).size.width,
                                    borderWidth: 1,
                                    borderColor: Colors.black54,
                                    text: "Select meal",
                                    textColor: TextColors.blackText),
                              ),
                              const SizedBox(height: 40),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                //final add button
                                child: DefaultButton(
                                  function: () {
                                    // print('add number $addNumber $addFood');
                                    // print(containerFoodList.food);
                                    // int listIndex = random.nextInt(4);
                                    // setState(() {
                                    //   containerFoodList[0].add(containerFoodList.food);
                                    // });
                                  },
                                  borderRadius: 30,
                                  text: 'Add',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                          visible: (nutrition.addNumber == 0) ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                            child: CircleButton(
                              onTap: () {
                                nutrition.foodListPanel.isPanelOpen
                                    ? nutrition.foodListPanel.close()
                                    : nutrition.foodListPanel.open();
                              },
                              backgroundColor: BackgroundColors.extraButton,
                              child: paragraphText(
                                  text: "+ ${nutrition.addNumber}", color: TextColors.blackText),
                            ),
                          ))
                    ]),
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                    panelBuilder: (scrollController) =>
                    // addFood.isEmpty
                    //     ? Center(
                    //     child: titleText(
                    //         text: "Empty List", color: TextColors.blackText))
                    //     :
                    //list of selected food
                    ListView.separated(
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: (index == 0) ? 10 : 0),
                          child: Row(
                            children: [
                              subTitleText(
                                  text: "addFood[index]",
                                  color: TextColors.blackText),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, bottom: 10),
                                child: CircleButton(
                                    onTap: () {
                                      // setState(() {
                                      //   addFood.removeAt(index);
                                      //   addNumber = addFood.length;
                                      // });
                                    },
                                    borderWidth: 0,
                                    borderColor: Colors.transparent,
                                    child: const Icon(Icons.minimize_sharp)),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const Divider(thickness: 2),
                        itemCount: 2
                    )
                ),
                body: FutureBuilder(
                  future: getMeals(),
                  builder: (_, snapshot){
                    if(snapshot.hasData){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 250.0, top: 10.0),
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            //breakfast
                            Column(
                              children: [
                                //green circle, title
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    const SizedBox(width: 7),
                                    paragraphText(text: "Breakfast")
                                  ],
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: BackgroundColors.inkWellBG,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (_, i) => defaultInkWell(
                                            isReplace: true,
                                            image: snapshot.data![i].image,
                                            title: snapshot.data![i].name,
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                paragraphText(text: "Protein: ${snapshot.data![i].protein}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Carbs ${snapshot.data![i].carbs}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Fats ${snapshot.data![i].fats}"),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: paragraphText(text: snapshot.data![i].quantity, color: Colors.white),
                                                ),
                                                const SizedBox(width: 15.0),
                                                paragraphText(text: "Calories: ${snapshot.data![i].calories}"),

                                              ],
                                            ),
                                            function: () {
                                              // addMealController.close();
                                              // navNavigator(
                                              //     context,
                                              //     FoodDetails(
                                              //         title: "foodTitle[index]"));
                                            }),
                                        separatorBuilder: (_, i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                    BackgroundColors.background)),
                                          ),
                                        ),
                                        itemCount: 2))
                              ],
                            ),
                            const SizedBox(height: 15),
                            //Snack
                            Column(
                              children: [
                                //green circle, title
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    const SizedBox(width: 7),
                                    paragraphText(text: "Snack")
                                  ],
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: BackgroundColors.inkWellBG,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (_, i) => defaultInkWell(
                                            isReplace: true,
                                            image: snapshot.data![i].image,
                                            title: snapshot.data![i].name,
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                paragraphText(text: "Protein: ${snapshot.data![i].protein}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Carbs ${snapshot.data![i].carbs}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Fats ${snapshot.data![i].fats}"),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: paragraphText(text: snapshot.data![i].quantity),
                                                ),
                                                const SizedBox(width: 15.0),
                                                paragraphText(text: "Calories: ${snapshot.data![i].calories}"),

                                              ],
                                            ),
                                            function: () {
                                              // addMealController.close();
                                              // navNavigator(
                                              //     context,
                                              //     FoodDetails(
                                              //         title: "foodTitle[index]"));
                                            }),
                                        separatorBuilder: (_, i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                    BackgroundColors.background)),
                                          ),
                                        ),
                                        itemCount: 2))
                              ],
                            ),
                            const SizedBox(height: 15),
                            //Lunch
                            Column(
                              children: [
                                //green circle, title
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    const SizedBox(width: 7),
                                    paragraphText(text: "Lunch")
                                  ],
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: BackgroundColors.inkWellBG,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (_, i) => defaultInkWell(
                                            isReplace: true,
                                            image: snapshot.data![i].image,
                                            title: snapshot.data![i].name,
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                paragraphText(text: "Protein: ${snapshot.data![i].protein}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Carbs ${snapshot.data![i].carbs}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Fats ${snapshot.data![i].fats}"),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: paragraphText(text: snapshot.data![i].quantity),
                                                ),
                                                const SizedBox(width: 15.0),
                                                paragraphText(text: "Calories: ${snapshot.data![i].calories}"),

                                              ],
                                            ),
                                            function: () {
                                              // addMealController.close();
                                              // navNavigator(
                                              //     context,
                                              //     FoodDetails(
                                              //         title: "foodTitle[index]"));
                                            }),
                                        separatorBuilder: (_, i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                    BackgroundColors.background)),
                                          ),
                                        ),
                                        itemCount: 2))
                              ],
                            ),
                            const SizedBox(height: 15),
                            //Dinner
                            Column(
                              children: [
                                //green circle, title
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    const SizedBox(width: 7),
                                    paragraphText(text: "Dinner")
                                  ],
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: BackgroundColors.inkWellBG,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (_, i) => defaultInkWell(
                                            isReplace: true,
                                            image: snapshot.data![i].image,
                                            title: snapshot.data![i].name,
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                paragraphText(text: "Protein: ${snapshot.data![i].protein}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Carbs ${snapshot.data![i].carbs}"),
                                                const SizedBox(width: 10.0),
                                                paragraphText(text: "Fats ${snapshot.data![i].fats}"),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: paragraphText(text: snapshot.data![i].quantity),
                                                ),
                                                const SizedBox(width: 15.0),
                                                paragraphText(text: "Calories: ${snapshot.data![i].calories}"),

                                              ],
                                            ),
                                            function: () {
                                              // addMealController.close();
                                              // navNavigator(
                                              //     context,
                                              //     FoodDetails(
                                              //         title: "foodTitle[index]"));
                                            }),
                                        separatorBuilder: (_, i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                    BackgroundColors.background)),
                                          ),
                                        ),
                                        itemCount: 2))
                              ],
                            ),

                          ],
                        ),
                      );
                    }else if(snapshot.hasError){
                      return Center(
                          child: titleText(text: "Error fetching data ${snapshot.error}")
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            );
          },
        )
    );
  }
}
