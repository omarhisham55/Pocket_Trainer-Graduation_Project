import 'dart:math';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/images.dart';
import 'package:fl_chart/fl_chart.dart';

class FoodDetails extends StatefulWidget {
  String? title;
  num? calories;
  num? protein;
  num? fats;
  num? iron;
  num? calcium;
  num? sodium;
  num? potassium;
  num? carbs;
  num? fiber;
  num? vitaminD;
  num? sugar;
  String? image;
  String? ingredients;

  FoodDetails({
    Key? key,
    this.title,
    this.image,
    this.ingredients,
    this.calories,
    this.protein,
    this.fats,
    this.iron,
    this.calcium,
    this.sodium,
    this.potassium,
    this.carbs,
    this.fiber,
    this.vitaminD,
    this.sugar,
  }) : super(key: key);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  int touchedIndex = 0;
  int randomNumber = Random().nextInt(2);

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.yellow,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, s) {},
        builder: (_, s) {
          CubitManager nutrition = CubitManager.get(_);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                Image.network(
                  widget.image ?? FoodImages.nutritionBg,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                FadeTransition(
                  opacity: _animation,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 200),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                subTitleText(
                                  text: widget.title ?? " ",
                                  color: TextColors.blackText,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          subTitleText(
                                            text: "Calories",
                                            color: TextColors.blackText,
                                          ),
                                          const Spacer(),
                                          subTitleText(
                                            text: "${widget.calories} Kcal",
                                            color: TextColors.blackText,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 50),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child:
                                                      BarChart(mainBarData()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: colors[x % colors.length],
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(3, (i) {
      switch (i) {
        case 0:
          // String newProtein =
          // widget.protein!.substring(0, widget.protein!.length - 1);
          return makeGroupData(0, double.parse('protein'));
        case 1:
          // String newCarbs =
          // widget.carbs!.substring(0, widget.carbs!.length - 1);
          return makeGroupData(1, double.parse('carbs'));
        case 2:
          // String newFats = widget.fats!.substring(0, widget.fats!.length - 1);
          return makeGroupData(2, double.parse('fats'));
        default:
          throw Error();
      }
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      maxY: 50,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: BackgroundColors.button,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String type;
              switch (group.x) {
                case 0:
                  type = 'Protein';
                  break;
                case 1:
                  type = 'Carbs';
                  break;
                case 2:
                  type = 'Fats';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                '$type\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: rod.toY.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
        )),
      ),
      borderData: FlBorderData(show: false),
      // barGroups: showingGroups(),
      gridData: FlGridData(show: true),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('protein', style: style);
        break;
      case 1:
        text = const Text('carbs', style: style);
        break;
      case 2:
        text = const Text('fats', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
