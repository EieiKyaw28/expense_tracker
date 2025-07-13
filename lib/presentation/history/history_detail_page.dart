import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/extensions.dart';

import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/presentation/history/widget/history_detail_card.dart';
import 'package:expense_tracker/presentation/history/history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({
    super.key,
    required this.month,
    required this.monthIndex,
  });
  final MonthModel month;
  final int monthIndex;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ExpenseController>().fetchExpenses(
        family: ExpenseFamilyModel(
          month: widget.monthIndex,
          year: 2025,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return CommonScaffold(
      appBar: CommonAppBar(
        hasDrawer: false,
        title: Text(
          "2025, ${widget.month.name} History",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerOnTap: () {
          drawerController.toggleDrawer();
        },
      ),
      body: GetBuilder<ExpenseController>(
        builder: (expenseController) {
          final expenses = expenseController.expenseList;
          return expenses.isEmpty
              ? Center(child: Lottie.asset('assets/json/empty_data.json'))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => 8.vGap,
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            return HistoryDetailCard(
                              expense: expenses[index],
                              month: widget.month,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
