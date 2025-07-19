import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/common/common_textfield.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/domain/month/month_model.dart';
import 'package:expense_tracker/presentation/history/history_detail_page.dart';
import 'package:expense_tracker/presentation/home/create_page.dart';
import 'package:expense_tracker/presentation/home/income_component.dart';
import 'package:expense_tracker/presentation/home/widget/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController incomeController = TextEditingController();
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
      incomeController.text = expenseController.income.toString();
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
          action: Row(
            children: [
              GetBuilder<ExpenseController>(builder: (expenseController) {
                return InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return _addIncomeWidget(
                          income: expenseController.budget.income,
                          onAdd: () async {
                            await expenseController.addIncome(
                              id: expenseController.budget.id,
                              income:
                                  double.tryParse(incomeController.text) ?? 0,
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    MyImage.expenseIcon,
                    height: 30,
                    width: 30,
                    color: MyTheme.primaryColor,
                  ),
                );
              }),
              10.hGap,
              InkWell(
                onTap: () {
                  Get.to(() => const CreatePage());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
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
              child: Column(
                children: [
                  IncomeComponent(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return _addIncomeWidget(
                            income: expenseController.budget.income,
                            onAdd: () async {
                              await expenseController.addIncome(
                                id: expenseController.budget.id,
                                income:
                                    double.tryParse(incomeController.text) ?? 0,
                              );
                            },
                          );
                        },
                      );
                    },
                    expenses: expenses,
                    income: expenseController.budget.income.toString(),
                    balance: expenseController.balance.toString(),
                  ),
                  10.vGap,
                  expenseController.expenseGroupByList.isEmpty
                      ? Center(
                          child: Lottie.asset('assets/json/empty_data.json'))
                      : Expanded(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(expenseItem.date),
                                        if (index == 0)
                                          InkWell(
                                              onTap: () {
                                                Get.to(() => HistoryDetailPage(
                                                      month: months[
                                                          DateTime.now().month -
                                                              1],
                                                      monthIndex:
                                                          DateTime.now().month,
                                                    ));
                                              },
                                              child: const Row(
                                                children: [
                                                  Text("View History"),
                                                  Icon(
                                                    Icons
                                                        .keyboard_double_arrow_right_outlined,
                                                    size: 16,
                                                  )
                                                ],
                                              )),
                                      ],
                                    ),
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

  Widget _addIncomeWidget({
    required Function() onAdd,
    double? income,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your budget for this month",
                    style: TextStyle(
                        color: MyTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              10.vGap,
              Image.asset(
                MyImage.incomeIcon,
                height: 100,
              ),
              10.vGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonTextField(
                      filledColor: MyTheme.bgColor,
                      controller: incomeController,
                    ),
                  ),
                  5.hGap,
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: MyTheme.primaryColor),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
