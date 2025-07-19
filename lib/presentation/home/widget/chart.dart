import 'package:expense_tracker/controller/chart_controller.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
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
                centerSpaceRadius: 20,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        Expanded(
          child: GetBuilder<ChartController>(builder: (controller) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commonExpenseList.length,
                itemBuilder: (context, index) {
                  return Indicator(
                    color: searchColorBySlug(commonExpenseList[index].slug),
                    text: commonExpenseList[index].title,
                  );
                });
          }),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final controller = Get.find<ChartController>();

    return List.generate(controller.expenseList.length, (i) {
      final chart = controller.expenseList[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 30.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: chart.color,
        value: 20,
        title: '${chart.percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.square,
          color: color,
        ),
        Text(text),
      ],
    );
  }
}
