import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/images.dart';
import 'package:fl_chart/fl_chart.dart';


class FoodDetails extends StatefulWidget {
  final String? title;
  final String? quantity;
  final String? calories;
  final String? protein;
  final String? carbs;
  final String? fats;
  final String? image;
  const FoodDetails({Key? key, this.title, this.image, this.quantity, this.calories, this.protein, this.carbs, this.fats}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Stack(
          children: [
            Image.network(
                widget.image ?? FoodImages.nutritionBg,
                width: double.infinity,
                fit: BoxFit.fitWidth
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          subTitleText(text: widget.title ?? " ",
                              color: TextColors.blackText,
                              fontWeight: FontWeight.w700),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    subTitleText(text: "Quantity", color: TextColors.blackText),
                                    const Spacer(),
                                    subTitleText(text: "${widget.quantity} gram", color: TextColors.blackText)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    subTitleText(text: "Calories", color: TextColors.blackText),
                                    const Spacer(),
                                    subTitleText(text: "${widget.calories} Kcal", color: TextColors.blackText)
                                  ],
                                ),
                                const SizedBox(height: 50),
                                AspectRatio(
                                  aspectRatio: 1.8,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse.touchedSection == null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex =
                                                pieTouchResponse.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 0,
                                      sections: showingSections(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]
                      ),
                    )
                  ]
                )
              )
            )
          ]
        ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 65.0 : 55.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '${widget.fats}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(widgetSize, const Color(0xfff8b250), 'Fats'),
            titlePositionPercentageOffset: .40,
            badgePositionPercentageOffset: .60,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: "${widget.protein}",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(widgetSize, const Color(0xfff8b250), 'Protein'),
            titlePositionPercentageOffset: .80,
            badgePositionPercentageOffset: .40,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 16,
            title: "${widget.carbs}",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(widgetSize, const Color(0xfff8b250), 'carbs'),
            titlePositionPercentageOffset: .70,
            badgePositionPercentageOffset: .50,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(widgetSize, const Color(0xfff8b250), 'others'),
            titlePositionPercentageOffset: .80,
            badgePositionPercentageOffset: .50,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}
class _Badge extends StatelessWidget {
  final String type;
  final double size;
  final Color borderColor;
  const _Badge(this.size, this.borderColor, this.type);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   shape: BoxShape.circle,
      //   border: Border.all(
      //     color: borderColor,
      //     width: 2,
      //   ),
      //   boxShadow: <BoxShadow>[
      //     BoxShadow(
      //       color: Colors.black.withOpacity(.5),
      //       offset: const Offset(3, 3),
      //       blurRadius: 3,
      //     ),
      //   ],
      // ),
      // padding: EdgeInsets.all(size * .15),
      child: Center(
        child: paragraphText(text: type),
      ),
    );
  }
}