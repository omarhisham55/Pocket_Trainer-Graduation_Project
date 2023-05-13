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
  final user = User.currentUser!.nutritionPlan!.values.toList();
  List selectedMeals = [];
  String selectedValue = "select meal time";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
          listener: (_, s) {
            if(s is DropDownState){
              selectedValue = s.selectedValue;
            }
          },
          builder: (_, s) {
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
                onPanelClosed: (){
                  print("add Meals $selectedMeals");
                },
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                //SlideUp panel for show food list when blue button appears
                panelBuilder: (scrollController) => SlidingUpPanel(
                    controller: nutrition.foodListPanel,
                    maxHeight: height(context, .3),
                    minHeight: 0.0,
                    onPanelClosed: (){nutrition.addMealController.open();},
                    body: FutureBuilder(
                      future: getNutritionHomeDataMapValues(),
                      builder: (_, snapshot) {
                        List<String> titles = [];
                        for(int i=0; i<snapshot.data!.length; i++){
                          titles.add(snapshot.data![i][0]);
                        }
                        return Stack(
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
                                            border: Border.all(
                                                width: 1, color: Colors.black54)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: defaultDropDownMenu(
                                                content: titles,
                                                hintColor: TextColors.blackText,
                                                hintValue: selectedValue,
                                                function: (value) {
                                                  print('object $value');
                                                  nutrition.dropDownSelect(value, selectedValue);
                                                })),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      //select meal button
                                      child: DefaultButton(
                                        function: () async {
                                          navNavigator(context, ChooseFood(selectedMeals: selectedMeals));
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
                                          if(selectedValue != "select meal time"){
                                            if(selectedMeals.isNotEmpty){
                                              toastSuccess(text: "Meals $selectedMeals added to $selectedValue");
                                              for(int i=0; i<selectedMeals.length; i++){
                                                nutrition.addMeal();
                                                nutrition.addMealController.close();
                                                // addMeals(mealId: selectedMeals[i].id);
                                              }
                                              addMeals(mealId: selectedMeals[0].id);
                                              showSnackBar(context: context, text: "Meals $selectedMeals added to $selectedValue");
                                              print('Meals $selectedMeals added to $selectedValue');
                                            }else{
                                              showSnackBar(context: context, text: "select meals");
                                              print("select meals");
                                            }
                                          }else{
                                            showSnackBar(context: context, text: "select meal time");
                                            print("select meal time");
                                          }
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
                        );
                      }
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    panelBuilder: (scrollController) => selectedMeals.isEmpty
                            ? Center(
                            child: titleText(
                                text: "Empty List", color: TextColors.blackText))
                            :
                        //list of selected food
                        ListView.separated(
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, top: (index == 0) ? 10 : 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width(context, .7),
                                        child: subTitleText(
                                          text: selectedMeals[index].name,
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
                                              nutrition.removeMeal(selectedMeals, index);
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
                            itemCount: selectedMeals.length
                        )
                ),
                body: FutureBuilder(
                  future: getBreakfast(),
                  builder: (_, snapshot) {
                    print("oppo ${User.currentUser!.nutritionPlan!}");
                    if (snapshot.hasData) {
                      print("lopsa ${snapshot.data}");
                      var snapshotData = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 250.0, top: 10.0),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, iTitle) {
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
                                    paragraphText(text: snapshotData[iTitle][0])
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
                                              image: "user[0][i].image",
                                              title: user[0][i].name,
                                              subtitle: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  paragraphText(
                                                      text:
                                                      "Protein: ${user[0][i].protein}"),
                                                  const SizedBox(width: 10.0),
                                                  paragraphText(
                                                      text:
                                                      "Carbs ${user[0][i].carbs}"),
                                                  const SizedBox(width: 10.0),
                                                  paragraphText(
                                                      text:
                                                      "Fats ${user[0][i].fats}"),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: paragraphText(
                                                        text: user[0][i].quantity,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(width: 15.0),
                                                  paragraphText(
                                                      text:
                                                      "Calories: ${user[0][i].calories}"),
                                                ],
                                              ),
                                              function: () {
                                                // nutrition.slidingPanel();
                                                navNavigator(context,
                                                    FoodDetails(
                                                      title: selectedMeals[i]
                                                          .name,
                                                      image: selectedMeals[i]
                                                          .image,
                                                      quantity: selectedMeals[i]
                                                          .quantity,
                                                      protein: selectedMeals[i]
                                                          .protein,
                                                      fats: selectedMeals[i]
                                                          .fats,
                                                      carbs: selectedMeals[i]
                                                          .carbs,
                                                      calories: selectedMeals[i]
                                                          .calories,
                                                    ));
                                              });
                                        },
                                        separatorBuilder: (_, i) =>
                                            Padding(
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
                                        itemCount: user.length))
                              ],
                            );
                          },
                          separatorBuilder: (_, iTitle) => const SizedBox(height: 15),
                          itemCount: 4,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: titleText(
                              text: "Error fetching data ${snapshot.error}"));
                    } else {
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
