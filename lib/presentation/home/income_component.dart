import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/constant/number_formatter.dart';
import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/presentation/home/widget/total_expense_componet.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IncomeComponent extends StatelessWidget {
  const IncomeComponent({
    super.key,
    required this.income,
    required this.balance,
    required this.expenses,
    required this.onTap,
  });
  final double? income;
  final String balance;
  final List<Expense> expenses;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: MyTheme.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TotalExpenseComponet(
                      totalAmount: expenses
                          .map((e) => e.amount)
                          .fold(0.0, (prev, element) => prev + (element ?? 0)),
                    ),
                    4.vGap,
                  ],
                ),
                Lottie.asset('assets/json/chart.json'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ((income ?? 0) <= 0)
                              ? const Column(
                                  children: [
                                    Icon(Icons.add),
                                    Text(
                                      "Add your budget",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Text(
                                      "Your Budget",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      "${numberFormatter(income.toString())} Ks",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                    ),
                  ),
                ),
                4.hGap,
                if ((income ?? 0) > 0)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              "Your Balance",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              "${numberFormatter(balance)} Ks",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
