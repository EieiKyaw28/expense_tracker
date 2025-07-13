import 'package:expense_tracker/common/common_app_bar.dart';

import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/constant/number_formatter.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/presentation/history/widget/history_card.dart';
import 'package:expense_tracker/presentation/history/history_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<MonthModel> months = [
  MonthModel(
    name: 'January',
    lightColor: Color(0xFFE3F2FD), // Light Blue
    darkColor: Color(0xFF90CAF9), // Darker Blue
  ),
  MonthModel(
    name: 'February',
    lightColor: Color(0xFFF8BBD0), // Pink
    darkColor: Color(0xFFF48FB1), // Dark Pink
  ),
  MonthModel(
    name: 'March',
    lightColor: Color(0xFFC8E6C9), // Mint Green
    darkColor: Color(0xFFA5D6A7), // Darker Mint
  ),
  MonthModel(
    name: 'April',
    lightColor: Color(0xFFFFF9C4), // Light Yellow
    darkColor: Color.fromARGB(255, 190, 175, 39), // Yellow
  ),
  MonthModel(
    name: 'May',
    lightColor: Color(0xFFD1C4E9), // Lavender
    darkColor: Color(0xFFB39DDB), // Deeper Lavender
  ),
  MonthModel(
    name: 'June',
    lightColor: Color.fromARGB(255, 240, 102, 60), // Peach
    darkColor: Color.fromARGB(255, 201, 50, 4), // Deeper Peach
  ),
  MonthModel(
    name: 'July',
    lightColor: Color(0xFFB2EBF2), // Cyan
    darkColor: Color(0xFF4DD0E1), // Deeper Cyan
  ),
  MonthModel(
    name: 'August',
    lightColor: Color(0xFFFFE0B2), // Soft Orange
    darkColor: Color(0xFFFFB74D), // Orange
  ),
  MonthModel(
    name: 'September',
    lightColor: Color(0xFFE6EE9C), // Lime Green
    darkColor: Color(0xFFD4E157), // Deeper Lime
  ),
  MonthModel(
    name: 'October',
    lightColor: Color.fromARGB(255, 44, 43, 66), // Light Olive
    darkColor: Color.fromARGB(255, 6, 4, 46), // Olive
  ),
  MonthModel(
    name: 'November',
    lightColor: Color(0xFFFFCDD2), // Rose
    darkColor: Color(0xFFE57373), // Deeper Rose
  ),
  MonthModel(
    name: 'December',
    lightColor: Color(0xFFB3E5FC), // Sky Blue
    darkColor: Color(0xFF4FC3F7), // Stronger Sky Blue
  ),
];

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final expenseController = Get.find<ExpenseController>();

      expenseController.getTotalForMonth(2025);
      expenseController.fetchExpenses(family: null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: const Text(
            "History",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          drawerOnTap: () {
            drawerController.toggleDrawer();
          },
        ),
        body: Container(
          color: MyTheme.bgColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 100,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return GetBuilder<ExpenseController>(
                          builder: (controller) {
                        final total =
                            controller.monthlyTotals[index + 1] ?? 0.0;
                        return HistoryCard(
                          month: months[index],
                          total: "${numberFormatter(total.toString())} Ks",
                          onTap: () {
                            Get.to(
                              () => HistoryDetailPage(
                                month: months[index],
                                monthIndex: index + 1,
                              ),
                            );
                          },
                        );
                      });
                    },
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

class MonthModel {
  final String name;
  final Color lightColor;
  final Color darkColor;

  MonthModel({
    required this.name,
    required this.lightColor,
    required this.darkColor,
  });
}
