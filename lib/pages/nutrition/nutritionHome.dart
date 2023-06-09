// ignore_for_file: must_be_immutable

import 'package:calender_picker/date_picker_widget.dart';
import 'package:circle_button/circle_button.dart';
import 'package:final_packet_trainer/data/nutritionData.dart';
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
            if (s is DropDownState) {
              selectedMealTime = s.selectedValue;
            }
          },
          builder: (_, s) {
            List<String> titles = ["Breakfast", "Lunch", "Dinner"];
            CubitManager nutrition = CubitManager.get(_);
            List<QudsPopupMenuBase> getMenuFoodItems(context) {
              return [
                QudsPopupMenuItem(
                    leading: const Icon(Icons.add),
                    title: const Text('Add meal'),
                    onPressed: () {
                      // nutrition.addMealController.isPanelOpen ? nutrition.addMealController.close() : nutrition.addMealController.open();
                      nutrition.slidingPanel(nutrition.addMealController);
                      nutrition.deleteButtonFood = false;
                      // setState(() {
                      //   deleteFoodButton = false;
                      // });
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Delete meal'),
                    onPressed: () {
                      if (nutrition.addMealController.isPanelClosed) {
                        nutrition.addMealController.close();
                      }
                      if (nutrition.foodListPanel.isPanelOpen) {
                        nutrition.foodListPanel.close();
                      }
                      nutrition.deleteButton();
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Diet info'),
                    onPressed: () {
                      Navigator.of(context).push(PremiumAnimation(
                          page:
                              RecommendedProgramNutritionInfo(fromHome: true)));
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

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  appBar: changeableAppBar(
                    context: context,
                    title: "Nutrition Home",
                    isRequirementsTaken: true,
                    replace: QudsPopupButton(
                        tooltip: 'open',
                        items: getMenuFoodItems(context),
                        child: const Icon(Icons.more_vert,
                            color: Colors.white, size: 30)),
                    /* bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(110.0),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // paragraphText(text: months[DateTime.now().month-1]),
                            // const SizedBox(height: 10),
                            CalenderPicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              daysCount: 6,
                              onDateChange: (date) {},
                            ),
                          ],
                        ),
                      ),
                    ), */
                  ),
                  backgroundColor: BackgroundColors.background,
                  body: SlidingUpPanel(
                    controller: nutrition.addMealController,
                    maxHeight: height(context, .4),
                    minHeight: 0.0,
                    onPanelClosed: () {},
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    //SlideUp panel for show food list when blue button appears
                    panelBuilder: (scrollController) => SlidingUpPanel(
                        controller: nutrition.foodListPanel,
                        maxHeight: height(context, .3),
                        minHeight: 0.0,
                        onPanelClosed: () {
                          nutrition.addMealController.open();
                        },
                        body: Stack(alignment: Alignment.topRight, children: [
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
                                          border: Border.all(
                                              width: 1, color: Colors.black54)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: defaultDropDownMenu(
                                              content: titles,
                                              hintColor: TextColors.blackText,
                                              hintValue: selectedMealTime,
                                              function: (value) {
                                                print('object $value');
                                                nutrition.dropDownSelect(
                                                    value, selectedMealTime);
                                              })),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    //select meal button
                                    child: DefaultButton(
                                        function: () async {
                                          if (selectedMealTime ==
                                              "select meal time") {
                                            toastWarning(
                                                context: context,
                                                text: "select meal time first");
                                          } else {
                                            navNavigator(
                                                context,
                                                ChooseFood(
                                                  selectedMeals:
                                                      nutrition.selectedMeals,
                                                  typeofMeal: selectedMealTime,
                                                ));
                                          }
                                        },
                                        backgroundColor:
                                            BackgroundColors.whiteBG,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderWidth: 1,
                                        borderColor: Colors.black54,
                                        text: "Select meal",
                                        textColor: TextColors.blackText),
                                  ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    //final add button
                                    child: DefaultButton(
                                      function: () {
                                        nutrition.addMeal(
                                            context, selectedMealTime);
                                        nutrition.selectedMeals = [];
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
                                  nutrition
                                      .slidingPanel(nutrition.foodListPanel);
                                },
                                backgroundColor: BackgroundColors.extraButton,
                                child: const Icon(FontAwesomeIcons.bowlFood)),
                          )
                        ]),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)),
                        panelBuilder: (scrollController) => nutrition
                                .selectedMeals.isEmpty
                            ? Center(
                                child: titleText(
                                    text: "Empty List",
                                    color: TextColors.blackText))
                            //list of selected food
                            : ListView.separated(
                                itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          top: (index == 0) ? 10 : 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width(context, .7),
                                            child: subTitleText(
                                                text: nutrition
                                                    .selectedMeals[index].name,
                                                color: TextColors.blackText,
                                                textAlign: TextAlign.left),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, bottom: 10),
                                            child: CircleButton(
                                                onTap: () {
                                                  nutrition.removeMeal(
                                                      nutrition.selectedMeals,
                                                      index);
                                                },
                                                borderWidth: 0,
                                                borderColor: Colors.transparent,
                                                child: const Icon(
                                                    Icons.minimize_sharp)),
                                          )
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const Divider(thickness: 2),
                                itemCount: nutrition.selectedMeals.length)),
                    body: InkWell(
                      onTap: () {
                        nutrition.addMealController.close();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 150.0,
                              top: 10.0,
                              right: 10.0,
                              left: 10.0),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              FutureBuilder(
                                  future: getBreakfastNutritionPlan(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      List breakfast = snapshot.data!;
                                      return Visibility(
                                          visible: (breakfast.isEmpty)
                                              ? false
                                              : true,
                                          child: Column(
                                            children: [
                                              //green circle, title
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  paragraphText(text: titles[0])
                                                ],
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: BackgroundColors
                                                          .inkWellBG,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ListView.separated(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (_, i) {
                                                        return defaultInkWell(
                                                            context: context,
                                                            remove: nutrition
                                                                .deleteButtonFood,
                                                            removeFunction: () {
                                                              nutrition
                                                                  .deleteMeals(
                                                                      mealId: breakfast[
                                                                              i]
                                                                          [
                                                                          'mealId'])
                                                                  .then(
                                                                      (value) {
                                                                toastSuccess(
                                                                    context:
                                                                        context,
                                                                    text:
                                                                        "${breakfast[i]['Food_items']} has been deleted");
                                                              });
                                                            },
                                                            image: breakfast[i][
                                                                    'imageUrl'] ??
                                                                "not found",
                                                            title: breakfast[i][
                                                                    'Food_items'] ??
                                                                "not found",
                                                            subtitle: [
                                                              paragraphText(
                                                                  text:
                                                                      "Protein: ${breakfast[i]['Proteins'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Carbs ${breakfast[i]['Carbohydrates'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Fats ${breakfast[i]['Fats'] ?? "not found"}"),
                                                            ],
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  child: paragraphText(
                                                                      text: breakfast[i]
                                                                              [
                                                                              'quantity'] ??
                                                                          "not found",
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        15.0),
                                                                paragraphText(
                                                                    text:
                                                                        "Calories: ${breakfast[i]['Calories'] ?? "not found"}"),
                                                              ],
                                                            ),
                                                            function: () {
                                                              // nutrition.slidingPanel();
                                                              navNavigator(
                                                                  context,
                                                                  FoodDetails(
                                                                    title: breakfast[i]
                                                                            [
                                                                            'Food_items'] ??
                                                                        "not found",
                                                                    image: breakfast[i]
                                                                            [
                                                                            'imageUrl'] ??
                                                                        "not found",
                                                                    protein: breakfast[i]
                                                                            [
                                                                            'Proteins'] ??
                                                                        "not found",
                                                                    fats: breakfast[i]
                                                                            [
                                                                            'Fats'] ??
                                                                        "not found",
                                                                    carbs: breakfast[i]
                                                                            [
                                                                            'Carbohydrates'] ??
                                                                        "not found",
                                                                    calories: breakfast[i]
                                                                            [
                                                                            'Calories'] ??
                                                                        "not found",
                                                                    calcium: breakfast[i]
                                                                            [
                                                                            'Calcium'] ??
                                                                        "not found",
                                                                    fiber: breakfast[i]
                                                                            [
                                                                            'Fibre'] ??
                                                                        "not found",
                                                                    ingredients:
                                                                        breakfast[i]['Ingredients'] ??
                                                                            "not found",
                                                                    iron: breakfast[i]
                                                                            [
                                                                            'Iron'] ??
                                                                        "not found",
                                                                    potassium: breakfast[i]
                                                                            [
                                                                            'Potassium'] ??
                                                                        "not found",
                                                                    vitaminD: breakfast[i]
                                                                            [
                                                                            'VitaminD'] ??
                                                                        "not found",
                                                                    sodium: breakfast[i]
                                                                            [
                                                                            'Sodium'] ??
                                                                        "not found",
                                                                    sugar: breakfast[i]
                                                                            [
                                                                            'Sugars'] ??
                                                                        "not found",
                                                                  ));
                                                            });
                                                      },
                                                      separatorBuilder: (_,
                                                              i) =>
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: BackgroundColors
                                                                          .background)),
                                                            ),
                                                          ),
                                                      itemCount:
                                                          breakfast.length))
                                            ],
                                          ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: titleText(
                                              text:
                                                  "Error fetching data ${snapshot.error}"));
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                              const SizedBox(height: 10.0),
                              FutureBuilder(
                                  future: getLunchNutritionPlan(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      List lunch = snapshot.data!;
                                      return Visibility(
                                          visible:
                                              (lunch.isEmpty) ? false : true,
                                          child: Column(
                                            children: [
                                              //green circle, title
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  paragraphText(text: titles[1])
                                                ],
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: BackgroundColors
                                                          .inkWellBG,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ListView.separated(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (_, i) {
                                                        return defaultInkWell(
                                                            context: context,
                                                            remove: nutrition
                                                                .deleteButtonFood,
                                                            removeFunction: () {
                                                              nutrition
                                                                  .deleteMeals(
                                                                      mealId: lunch[
                                                                              i]
                                                                          [
                                                                          'mealId'])
                                                                  .then(
                                                                      (value) {
                                                                toastSuccess(
                                                                    context:
                                                                        context,
                                                                    text:
                                                                        "${lunch[i]['Food_items']} has been deleted");
                                                              });
                                                            },
                                                            image: lunch[i][
                                                                    'imageUrl'] ??
                                                                "not found",
                                                            title: lunch[i][
                                                                    'Food_items'] ??
                                                                "not found",
                                                            subtitle: [
                                                              paragraphText(
                                                                  text:
                                                                      "Protein: ${lunch[i]['Proteins'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Carbs ${lunch[i]['Carbohydrates'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Fats ${lunch[i]['Fats'] ?? "not found"}"),
                                                            ],
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  child: paragraphText(
                                                                      text: lunch[i]
                                                                              [
                                                                              'quantity'] ??
                                                                          "not found",
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        15.0),
                                                                paragraphText(
                                                                    text:
                                                                        "Calories: ${lunch[i]['Calories'] ?? "not found"}"),
                                                              ],
                                                            ),
                                                            function: () {
                                                              // nutrition.slidingPanel();
                                                              navNavigator(
                                                                  context,
                                                                  FoodDetails(
                                                                    title: lunch[i]
                                                                            [
                                                                            'Food_items'] ??
                                                                        "not found",
                                                                    image: lunch[i]
                                                                            [
                                                                            'imageUrl'] ??
                                                                        "not found",
                                                                    protein: lunch[i]
                                                                            [
                                                                            'Proteins'] ??
                                                                        "not found",
                                                                    fats: lunch[i]
                                                                            [
                                                                            'Fats'] ??
                                                                        "not found",
                                                                    carbs: lunch[i]
                                                                            [
                                                                            'Carbohydrates'] ??
                                                                        "not found",
                                                                    calories: lunch[i]
                                                                            [
                                                                            'Calories'] ??
                                                                        "not found",
                                                                    calcium: lunch[i]
                                                                            [
                                                                            'Calcium'] ??
                                                                        "not found",
                                                                    fiber: lunch[i]
                                                                            [
                                                                            'Fibre'] ??
                                                                        "not found",
                                                                    ingredients:
                                                                        lunch[i]['Ingredients'] ??
                                                                            "not found",
                                                                    iron: lunch[i]
                                                                            [
                                                                            'Iron'] ??
                                                                        "not found",
                                                                    potassium: lunch[i]
                                                                            [
                                                                            'Potassium'] ??
                                                                        "not found",
                                                                    vitaminD: lunch[i]
                                                                            [
                                                                            'VitaminD'] ??
                                                                        "not found",
                                                                    sodium: lunch[i]
                                                                            [
                                                                            'Sodium'] ??
                                                                        "not found",
                                                                    sugar: lunch[i]
                                                                            [
                                                                            'Sugars'] ??
                                                                        "not found",
                                                                  ));
                                                            });
                                                      },
                                                      separatorBuilder: (_,
                                                              i) =>
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: BackgroundColors
                                                                          .background)),
                                                            ),
                                                          ),
                                                      itemCount: lunch.length))
                                            ],
                                          ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: titleText(
                                              text:
                                                  "Error fetching data ${snapshot.error}"));
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                              const SizedBox(height: 10.0),
                              FutureBuilder(
                                  future: getDinnerNutritionPlan(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      List dinner = snapshot.data!;
                                      return Visibility(
                                          visible:
                                              (dinner.isEmpty) ? false : true,
                                          child: Column(
                                            children: [
                                              //green circle, title
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  paragraphText(text: titles[2])
                                                ],
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: BackgroundColors
                                                          .inkWellBG,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ListView.separated(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (_, i) {
                                                        return defaultInkWell(
                                                            context: context,
                                                            remove: nutrition
                                                                .deleteButtonFood,
                                                            removeFunction: () {
                                                              nutrition
                                                                  .deleteMeals(
                                                                      mealId: dinner[
                                                                              i]
                                                                          [
                                                                          'mealId'])
                                                                  .then(
                                                                      (value) {
                                                                toastSuccess(
                                                                    context:
                                                                        context,
                                                                    text:
                                                                        "${dinner[i]['Food_items']} has been deleted");
                                                              });
                                                            },
                                                            image: dinner[i][
                                                                    'imageUrl'] ??
                                                                "not found",
                                                            title: dinner[i][
                                                                    'Food_items'] ??
                                                                "not found",
                                                            subtitle: [
                                                              paragraphText(
                                                                  text:
                                                                      "Protein: ${dinner[i]['Proteins'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Carbs ${dinner[i]['Carbohydrates'] ?? "not found"}"),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              paragraphText(
                                                                  text:
                                                                      "Fats ${dinner[i]['Fats'] ?? "not found"}"),
                                                            ],
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  child: paragraphText(
                                                                      text: dinner[i]
                                                                              [
                                                                              'quantity'] ??
                                                                          "not found",
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        15.0),
                                                                paragraphText(
                                                                    text:
                                                                        "Calories: ${dinner[i]['Calories'] ?? "not found"}"),
                                                              ],
                                                            ),
                                                            function: () {
                                                              // nutrition.slidingPanel();
                                                              navNavigator(
                                                                  context,
                                                                  FoodDetails(
                                                                    title: dinner[i]
                                                                            [
                                                                            'Food_items'] ??
                                                                        "not found",
                                                                    image: dinner[i]
                                                                            [
                                                                            'imageUrl'] ??
                                                                        "not found",
                                                                    protein: dinner[i]
                                                                            [
                                                                            'Proteins'] ??
                                                                        "not found",
                                                                    fats: dinner[i]
                                                                            [
                                                                            'Fats'] ??
                                                                        "not found",
                                                                    carbs: dinner[i]
                                                                            [
                                                                            'Carbohydrates'] ??
                                                                        "not found",
                                                                    calories: dinner[i]
                                                                            [
                                                                            'Calories'] ??
                                                                        "not found",
                                                                    calcium: dinner[i]
                                                                            [
                                                                            'Calcium'] ??
                                                                        "not found",
                                                                    fiber: dinner[i]
                                                                            [
                                                                            'Fibre'] ??
                                                                        "not found",
                                                                    ingredients:
                                                                        dinner[i]['Ingredients'] ??
                                                                            "not found",
                                                                    iron: dinner[i]
                                                                            [
                                                                            'Iron'] ??
                                                                        "not found",
                                                                    potassium: dinner[i]
                                                                            [
                                                                            'Potassium'] ??
                                                                        "not found",
                                                                    vitaminD: dinner[i]
                                                                            [
                                                                            'VitaminD'] ??
                                                                        "not found",
                                                                    sodium: dinner[i]
                                                                            [
                                                                            'Sodium'] ??
                                                                        "not found",
                                                                    sugar: dinner[i]
                                                                            [
                                                                            'Sugars'] ??
                                                                        "not found",
                                                                  ));
                                                            });
                                                      },
                                                      separatorBuilder: (_,
                                                              i) =>
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
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
                                          ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: titleText(
                                              text:
                                                  "Error fetching data ${snapshot.error}"));
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          )),
                    ),
                  ),
                ),
                //done button of delete meal
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Visibility(
                      visible: (nutrition.deleteButtonFood) ? true : false,
                      child: DefaultButton(
                        function: () {
                          nutrition.deleteButton();
                        },
                        text: "Done",
                        backgroundColor: Colors.red,
                      )),
                )
              ],
            );
          },
        ));
  }
}
