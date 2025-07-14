import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:expense_tracker/presentation/history/expense_type_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _tab = ['Month', 'Year', 'Type'];

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return CommonScaffold(
      backgroundColor: MyTheme.bgColor,
      appBar: CommonAppBar(
        drawerOnTap: () {
          drawerController.toggleDrawer();
        },
        title:
            const Text('Chart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  _tab.length,
                  (index) {
                    return Expanded(
                      child: TabButton(
                        title: _tab[index],
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                ),
              ),
              16.vGap,
              const ExpenseTypePieChart(),
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expense Types',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.vGap,
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 40,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          itemCount: commonExpenseList.length,
                          itemBuilder: (context, index) {
                            final item = commonExpenseList[index];
                            return Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: searchColorBySlug(item.slug),
                                      width: 2,
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: .2),
                                        offset: const Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Center(
                                    child: Image.asset(
                                      item.image,
                                    ),
                                  ),
                                ),
                                10.hGap,
                                // Image.asset(
                                //   item.image,
                                //   height: 30,
                                //   width: 30,
                                //   color: searchColorBySlug(item.slug),
                                // ),
                                // 10.hGap,
                                Text(
                                  item.title,
                                )
                              ],
                            );
                          }),
                      16.vGap,
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Data shown here are only randomly generated.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  const TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected ? MyTheme.primaryColor : Colors.black12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class LineChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(show: false),
//         borderData: FlBorderData(show: false),
//         extraLinesData: ExtraLinesData(
//           horizontalLines: [
//             HorizontalLine(color: Colors.grey, y: 0, strokeWidth: 1),
//             HorizontalLine(color: Colors.grey, y: 1),
//             HorizontalLine(color: Colors.grey, y: 7),
//             HorizontalLine(color: Colors.grey, y: 3),
//             HorizontalLine(color: Colors.grey, y: 4),
//           ],
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 0),
//               FlSpot(1, 100),
//               FlSpot(2, -100),
//               FlSpot(3, 200),
//               FlSpot(4, 300),
//               FlSpot(5, 600),
//             ],
//             isCurved: true,
//             color: Colors.orange,
//             barWidth: 3,
//             isStrokeCapRound: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
