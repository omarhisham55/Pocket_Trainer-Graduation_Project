import 'package:final_packet_trainer/pages/nutrition/nutritionHome.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:flutter/material.dart';
import '/shared/components/components.dart';
import 'package:circle_button/circle_button.dart';
import '/shared/styles/colors.dart';
import '/shared/styles/images.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecommendedProgramNutritionInfo extends StatefulWidget {
  final String? calories;
  final String? protein;
  final String? carbs;
  final String? fats;
  final String? goal;
  final String? general;
  bool? fromHome;

  RecommendedProgramNutritionInfo(
      {Key? key,
      this.calories,
      this.protein,
      this.carbs,
      this.fats,
      this.goal,
      this.general,
      this.fromHome})
      : super(key: key);

  @override
  State<RecommendedProgramNutritionInfo> createState() =>
      _RecommendedProgramNutritionInfoState();
}

class _RecommendedProgramNutritionInfoState
    extends State<RecommendedProgramNutritionInfo> {
  @override
  void initState() {
    defaultStatePanel = PanelState.CLOSED;
    super.initState();
  }
  PanelState defaultStatePanel = PanelState.CLOSED;
  PanelController foodTimeController = PanelController();
  Color? pmB = BackgroundColors.button;
  Color? pmS = BackgroundColors.button;
  Color? pmL = BackgroundColors.button;
  Color? pmD = BackgroundColors.button;
  bool isAmB = true;
  bool isAmS = true;
  bool isAmL = true;
  bool isAmD = true;
  String valueB = hours().first;
  String valueS = hours().first;
  String valueL = hours().first;
  String valueD = hours().first;

  @override
  Widget build(BuildContext context) {
    String textB = (isAmB) ? "am" : "pm";
    String textS = (isAmS) ? "am" : "pm";
    String textL = (isAmL) ? "am" : "pm";
    String textD = (isAmD) ? "am" : "pm";
    List<String> foodTime = ["Breakfast", "Snack", "Lunch", "Dinner"];
    List<String> time = [
      "$valueB $textB",
      "$valueS $textS",
      "$valueL $textL",
      "$valueD $textD"
    ];
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading:
                const Icon(Icons.arrow_back_ios, color: Colors.transparent),
            title: Center(child: titleText(text: 'Diet information')),
            actions: [
              Visibility(
                  visible: (widget.fromHome!) ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: TextColors.whiteText, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ))
            ]),
        body: SlidingUpPanel(
          controller: foodTimeController,
          minHeight: height(context, 0),
          maxHeight: height(context, .6),
          defaultPanelState: defaultStatePanel,
          panelBuilder: (scrollController) => Padding(
            padding: const EdgeInsets.all(30.0),
            //slidingUp meal time setup
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subTitleText(
                    text: "What time do you prefer having your meals ?",
                    color: TextColors.blackText),
                const SizedBox(height: 20),
                //Breakfast time setup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: BackgroundColors.extraButton),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: subTitleText(
                            text: "Breakfast", color: TextColors.blackText),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: defaultDropDownMenu(
                              hintColor: TextColors.blackText,
                              content: hours(),
                              hintValue: valueB,
                              function: (newValue) {
                                setState(() {
                                  valueB = newValue!;
                                });
                              },
                            )),
                        const SizedBox(width: 8),
                        CircleButton(
                            onTap: () {
                              setState(() {
                                isAmB = !isAmB;
                                pmB = (isAmB)
                                    ? BackgroundColors.button
                                    : BackgroundColors.background;
                              });
                            },
                            backgroundColor: pmB,
                            child: paragraphText(text: textB)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                //Snack time setup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: BackgroundColors.extraButton),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: subTitleText(
                            text: "Snack", color: TextColors.blackText),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: defaultDropDownMenu(
                              hintColor: TextColors.blackText,
                              content: hours(),
                              hintValue: valueS,
                              function: (newValue) {
                                setState(() {
                                  valueS = newValue!;
                                });
                              },
                            )),
                        const SizedBox(width: 8),
                        CircleButton(
                            onTap: () {
                              setState(() {
                                isAmS = !isAmS;
                                pmS = (isAmS)
                                    ? BackgroundColors.button
                                    : BackgroundColors.background;
                              });
                            },
                            backgroundColor: pmS,
                            child: paragraphText(text: textS)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                //Lunch time setup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: BackgroundColors.extraButton),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: subTitleText(
                            text: "Lunch", color: TextColors.blackText),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: defaultDropDownMenu(
                              hintColor: TextColors.blackText,
                                content: hours(),
                                hintValue: valueL,
                                function: (newValue) {
                                  setState(() {
                                    valueL = newValue!;
                                  });
                                })),
                        const SizedBox(width: 8),
                        CircleButton(
                            onTap: () {
                              setState(() {
                                isAmL = !isAmL;
                                pmL = (isAmL)
                                    ? BackgroundColors.button
                                    : BackgroundColors.background;
                              });
                            },
                            backgroundColor: pmL,
                            child: paragraphText(text: textL)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                //Dinner time setup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: BackgroundColors.extraButton),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: subTitleText(
                            text: "Dinner", color: TextColors.blackText),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: defaultDropDownMenu(
                              hintColor: TextColors.blackText,
                              content: hours(),
                              hintValue: valueD,
                              function: (newValue) {
                                setState(() {
                                  valueD = newValue!;
                                });
                              },
                            )),
                        const SizedBox(width: 8),
                        CircleButton(
                            onTap: () {
                              setState(() {
                                isAmD = !isAmD;
                                pmD = (isAmD)
                                    ? BackgroundColors.button
                                    : BackgroundColors.background;
                              });
                            },
                            backgroundColor: pmD,
                            child: paragraphText(text: textD)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                //save button
                DefaultButton(
                    function: () {
                      print(foodTime);
                      print(time);
                      pushReplacement(context, const NutritionHome());
                      // navNavigator(context, const NutritionHome());
                    },
                    text: "Save",
                    borderRadius: 30)
              ],
            ),
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          body: InkWell(
            onTap: () {
              foodTimeController.close();
            },
            child: Stack(
              children: [
                Image.asset(FoodImages.nutritionBg,
                    width: double.infinity, fit: BoxFit.fitWidth),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 200),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(
                              text: "Gain Diet",
                              color: TextColors.blackText,
                              fontWeight: FontWeight.w700),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  //calories
                                  Row(
                                    children: [
                                      paragraphText(
                                        text: "Calories: ",
                                        color: TextColors.blackText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      paragraphText(
                                        text: "${widget.calories} Kcal",
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //protein, carbs and fats
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          paragraphText(
                                            text: "Protein: ",
                                            color: TextColors.blackText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          paragraphText(
                                            text: "${widget.protein} g",
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          paragraphText(
                                            text: "Carbs: ",
                                            color: TextColors.blackText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          paragraphText(
                                            text: "${widget.carbs} g",
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          paragraphText(
                                            text: "Fats: ",
                                            color: TextColors.blackText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          paragraphText(
                                            text: "${widget.fats} g",
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //goal
                                  Row(
                                    children: [
                                      paragraphText(
                                        text: "Goal: ",
                                        color: TextColors.blackText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      paragraphText(
                                        text: "${widget.goal}",
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //notes
                                  Row(
                                    children: [
                                      paragraphText(
                                        text:
                                            "General instructions for the diet: ",
                                        color: TextColors.blackText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      paragraphText(
                                        text: "${widget.general}",
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                //Set as default button
                Positioned(
                  bottom: 100,
                  left: MediaQuery.of(context).size.width * .25,
                  child: Visibility(
                    visible: (widget.fromHome!) ? false : true,
                    child: DefaultButton(
                        function: () {
                          foodTimeController.isPanelOpen
                              ? foodTimeController.close()
                              : foodTimeController.open();
                        },
                        width: MediaQuery.of(context).size.width * .5,
                        borderRadius: 30,
                        text: 'Set as default'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
List<String> hours(){
  List<String> day = [];
  for(int i=1; i<=12; i++) {
    day.add("$i : 00");
  }
  return day;
}

