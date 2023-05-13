import 'package:circle_button/circle_button.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
import 'package:final_packet_trainer/data/userData.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../navigation/animationNavigation.dart';
import '../../shared/components/components.dart';
import '../gym/gym.dart';
import 'diet_recommended_plan.dart';
import 'food_details.dart';
import 'food_selection.dart';

class NutritionHome extends StatelessWidget {
  NutritionHome({Key? key}) : super(key: key);
  // final user = User.currentUser!.nutritionPlan!.values.toList();
  String selectedMealTime = "select meal time";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
          listener: (_, s) {
            if(s is DropDownState){
              selectedMealTime = s.selectedValue;
            }
          },
          builder: (_, s) {
            List<String> titles = ["breakfast", "lunch", "dinner"];
            CubitManager nutrition = CubitManager.get(_);
            List<QudsPopupMenuBase> getMenuFoodItems(context) {
              return [
                QudsPopupMenuItem(
                    leading: const Icon(Icons.add),
                    title: const Text('Add meal'),
                    onPressed: () {
                      // nutrition.addMealController.isPanelOpen ? nutrition.addMealController.close() : nutrition.addMealController.open();
                      nutrition.slidingPanel(nutrition.addMealController);
                      // setState(() {
                      //   deleteFoodButton = false;
                      // });
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Delete meal'),
                    onPressed: () {
                      // setState((){
                      //   panelController.close();
                      //   foodPanelController.close();
                      //   deleteFoodButton = true;
                      // });
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Diet info'),
                    onPressed: () {
                      Navigator.of(context).push(PremiumAnimation(
                          page: RecommendedProgramNutritionInfo(fromHome: true)));
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.language_outlined),
                    title: const Text('Change language'),
                    onPressed: () {
                      // showToast('Feedback Pressed!');
                      // print(containerFoodList);
                    }),
              ];
            }
            return Scaffold(
              appBar: changeableAppBar(
                context: context,
                title: "Nutrition Home",
                isRequirementsTaken: true,
                replace: QudsPopupButton(
                    tooltip: 'open',
                    items: getMenuFoodItems(context),
                    child: const Icon(Icons.more_vert, color: Colors.white, size: 30)),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(110.0),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: buildDaysOfWeek((date){

                    }),
                  ),
                ),
              ),
              backgroundColor: BackgroundColors.background,
              body: SlidingUpPanel(
                controller: nutrition.addMealController,
                maxHeight: height(context, .4),
                minHeight: 0.0,
                onPanelClosed: (){},
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                //SlideUp panel for show food list when blue button appears
                panelBuilder: (scrollController) => SlidingUpPanel(
                    controller: nutrition.foodListPanel,
                    maxHeight: height(context, .3),
                    minHeight: 0.0,
                    onPanelClosed: (){nutrition.addMealController.open();},
                    body: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () => nutrition.foodListPanel.close(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 20.0),
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
                                          border: Border.all(width: 1, color: Colors.black54)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: defaultDropDownMenu(
                                              content: titles,
                                              hintColor: TextColors.blackText,
                                              hintValue: selectedMealTime,
                                              function: (value) {
                                                print('object $value');
                                                nutrition.dropDownSelect(value, selectedMealTime);
                                              })),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    //select meal button
                                    child: DefaultButton(
                                        function: () async {
                                          navNavigator(context, ChooseFood(selectedMeals: nutrition.selectedMeals));
                                        },
                                        backgroundColor: BackgroundColors.whiteBG,
                                        width: MediaQuery.of(context).size.width,
                                        borderWidth: 1,
                                        borderColor: Colors.black54,
                                        text: "Select meal",
                                        textColor: TextColors.blackText
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    //final add button
                                    child: DefaultButton(
                                      function: () {
                                        nutrition.addMeal(context);
                                      },
                                      borderRadius: 30,
                                      text: 'Add',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 20.0, right: 20.0),
                            child: CircleButton(
                                onTap: () {
                                  nutrition.slidingPanel(nutrition.foodListPanel);
                                },
                                backgroundColor: BackgroundColors.extraButton,
                                child: const Icon(FontAwesomeIcons.bowlFood)
                            ),
                          )
                        ]
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    panelBuilder: (scrollController) => nutrition.selectedMeals.isEmpty ?
                      Center(child: titleText(text: "Empty List", color: TextColors.blackText))
                      //list of selected food
                      : ListView.separated(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, top: (index == 0) ? 10 : 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width(context, .7),
                              child: subTitleText(
                                  text: nutrition.selectedMeals[index].name,
                                  color: TextColors.blackText,
                                  textAlign: TextAlign.left
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, bottom: 10),
                              child: CircleButton(
                                  onTap: () {
                                    nutrition.removeMeal(nutrition.selectedMeals, index);
                                  },
                                  borderWidth: 0,
                                  borderColor: Colors.transparent,
                                  child: const Icon(
                                      Icons.minimize_sharp)
                              ),
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(thickness: 2),
                      itemCount: nutrition.selectedMeals.length
                  )
                ),
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 250.0, top: 10.0),
                  child: ListView(
                    children: [
                      FutureBuilder(
                          future: getBreakfast(),
                          builder: (_, snapshot){
                            if(snapshot.hasData){
                              List breakfast = snapshot.data!;
                              return Column(
                                children: [
                                  //green circle, title
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.green,
                                      ),
                                      const SizedBox(width: 7),
                                      paragraphText(text: titles[0])
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: BackgroundColors.inkWellBG,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (_, i) {
                                            return defaultInkWell(
                                                isReplace: true,
                                                image: breakfast[i]['imageUrl'] ?? "not found",
                                                title: breakfast[i]['name'] ?? "not found",
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    paragraphText(
                                                        text:
                                                        "Protein: ${breakfast[i]['protein'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Carbs ${breakfast[i]['carbs'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Fats ${breakfast[i]['fats'] ?? "not found"}"),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.red,
                                                      child: paragraphText(
                                                          text: breakfast[i]['quantity'] ?? "not found",
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    paragraphText(
                                                        text:
                                                        "Calories: ${breakfast[i]['calories'] ?? "not found"}"),
                                                  ],
                                                ),
                                                function: () {
                                                  // nutrition.slidingPanel();
                                                  navNavigator(context,
                                                      FoodDetails(
                                                        title: breakfast[i]['name'] ?? "not found",
                                                        image: breakfast[i]['imageUrl'] ?? "not found",
                                                        quantity: breakfast[i]['quantity'] ?? "not found",
                                                        protein: breakfast[i]['protein'] ?? "not found",
                                                        fats: breakfast[i]['fats'] ?? "not found",
                                                        carbs: breakfast[i]['carbs'] ?? "not found",
                                                        calories: breakfast[i]['calories'] ?? "not found",
                                                      ));
                                                });
                                          },
                                          separatorBuilder: (_, i) => Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: BackgroundColors
                                                          .background)),
                                            ),
                                          ),
                                          itemCount: breakfast.length))
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: titleText(
                                      text: "Error fetching data ${snapshot.error}"));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          }
                      ),
                      FutureBuilder(
                          future: getLunch(),
                          builder: (_, snapshot){
                            if(snapshot.hasData){
                              List lunch = snapshot.data!;
                              return Column(
                                children: [
                                  //green circle, title
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.green,
                                      ),
                                      const SizedBox(width: 7),
                                      paragraphText(text: titles[1])
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: BackgroundColors.inkWellBG,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (_, i) {
                                            return defaultInkWell(
                                                isReplace: true,
                                                image: lunch[i]['imageUrl'] ?? "not found",
                                                title: lunch[i]['name'] ?? "not found",
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    paragraphText(
                                                        text:
                                                        "Protein: ${lunch[i]['protein'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Carbs ${lunch[i]['carbs'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Fats ${lunch[i]['fats'] ?? "not found"}"),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.red,
                                                      child: paragraphText(
                                                          text: lunch[i]['quantity'] ?? "not found",
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    paragraphText(
                                                        text:
                                                        "Calories: ${lunch[i]['calories'] ?? "not found"}"),
                                                  ],
                                                ),
                                                function: () {
                                                  // nutrition.slidingPanel();
                                                  navNavigator(context,
                                                      FoodDetails(
                                                        title: lunch[i]['name'] ?? "not found",
                                                        image: lunch[i]['imageUrl'] ?? "not found",
                                                        quantity: lunch[i]['quantity'] ?? "not found",
                                                        protein: lunch[i]['protein'] ?? "not found",
                                                        fats: lunch[i]['fats'] ?? "not found",
                                                        carbs: lunch[i]['carbs'] ?? "not found",
                                                        calories: lunch[i]['calories'] ?? "not found",
                                                      ));
                                                });
                                          },
                                          separatorBuilder: (_, i) => Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: BackgroundColors.background)),
                                            ),
                                          ),
                                          itemCount: lunch.length))
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: titleText(
                                      text: "Error fetching data ${snapshot.error}"));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          }
                      ),
                      FutureBuilder(
                          future: getDinner(),
                          builder: (_, snapshot){
                            if(snapshot.hasData){
                              List dinner = snapshot.data!;
                              return Column(
                                children: [
                                  //green circle, title
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.green,
                                      ),
                                      const SizedBox(width: 7),
                                      paragraphText(text: titles[2])
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: BackgroundColors.inkWellBG,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (_, i) {
                                            return defaultInkWell(
                                                isReplace: true,
                                                image: dinner[i]['imageUrl'] ?? "not found",
                                                title: dinner[i]['name'] ?? "not found",
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    paragraphText(
                                                        text:
                                                        "Protein: ${dinner[i]['protein'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Carbs ${dinner[i]['carbs'] ?? "not found"}"),
                                                    const SizedBox(width: 10.0),
                                                    paragraphText(
                                                        text:
                                                        "Fats ${dinner[i]['fats'] ?? "not found"}"),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.red,
                                                      child: paragraphText(
                                                          text: dinner[i]['quantity'] ?? "not found",
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    paragraphText(
                                                        text:
                                                        "Calories: ${dinner[i]['calories'] ?? "not found"}"),
                                                  ],
                                                ),
                                                function: () {
                                                  // nutrition.slidingPanel();
                                                  navNavigator(context,
                                                      FoodDetails(
                                                        title: dinner[i]['name'] ?? "not found",
                                                        image: dinner[i]['imageUrl'] ?? "not found",
                                                        quantity: dinner[i]['quantity'] ?? "not found",
                                                        protein: dinner[i]['protein'] ?? "not found",
                                                        fats: dinner[i]['fats'] ?? "not found",
                                                        carbs: dinner[i]['carbs'] ?? "not found",
                                                        calories: dinner[i]['calories'] ?? "not found",
                                                      ));
                                                });
                                          },
                                          separatorBuilder: (_, i) => Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: BackgroundColors
                                                          .background)),
                                            ),
                                          ),
                                          itemCount: dinner.length))
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: titleText(
                                      text: "Error fetching data ${snapshot.error}"));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          }
                      ),
                    ],
                  )
                ),
              ),
            );
          },
        )
    );
  }
}
