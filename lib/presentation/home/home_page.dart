import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/presentation/home/create_page.dart';
import 'package:expense_tracker/presentation/widget/expense_card.dart';
import 'package:expense_tracker/presentation/widget/total_expense_componet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final date = DateTime.now();
      final expenseController = Get.find<ExpenseController>();

      expenseController.fetchExpenses(
          family: ExpenseFamilyModel(
        month: date.month,
        year: date.year,
      ));
      expenseController.fetchExpensesGroupBy(
          family: ExpenseFamilyModel(
        month: date.month,
        year: date.year,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return CommonScaffold(
        appBar: CommonAppBar(
          title: const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          action: InkWell(
            onTap: () {
              Get.to(() => const CreatePage());
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          drawerOnTap: () {
            drawerController.toggleDrawer();
          },
        ),
        body: GetBuilder<ExpenseController>(builder: (expenseController) {
          final expenses = expenseController.expenseList;
          return Container(
            color: MyTheme.bgColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: expenseController.expenseGroupByList.isEmpty
                  ? Center(child: Lottie.asset('assets/json/empty_data.json'))
                  : Column(
                      children: [
                        TotalExpenseComponet(
                          totalAmount: expenses.map((e) => e.amount).fold(
                              0.0, (prev, element) => prev + (element ?? 0)),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: ListView.separated(
                              separatorBuilder: (context, index) => 10.vGap,
                              shrinkWrap: true,
                              itemCount:
                                  expenseController.expenseGroupByList.length,
                              itemBuilder: (context, index) {
                                final expenseItem =
                                    expenseController.expenseGroupByList[index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(expenseItem.date),
                                    10.vGap,
                                    ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            10.vGap,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: expenseItem.expense.length,
                                        itemBuilder: (context, iIndex) {
                                          final item =
                                              expenseItem.expense[iIndex];
                                          return ExpenseCard(
                                            expense: item,
                                            onDelete: () {
                                              expenseController.deleteExpense(
                                                expenseController.budget.id,
                                                item.createdAt!,
                                              );
                                            },
                                          );
                                        }),
                                  ],
                                );
                              }),
                        ))
                      ],
                    ),
            ),
          );
        }));
  }
}
