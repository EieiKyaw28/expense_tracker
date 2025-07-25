import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';

import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/constant/number_formatter.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/month/month_model.dart';
import 'package:expense_tracker/presentation/history/widget/history_card.dart';
import 'package:expense_tracker/presentation/history/history_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    return CommonScaffold(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 100,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    return GetBuilder<ExpenseController>(builder: (controller) {
                      final total = controller.monthlyTotals[index + 1] ?? 0.0;
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
    );
  }
}
