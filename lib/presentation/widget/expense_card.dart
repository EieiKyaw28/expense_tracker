import 'dart:developer';

import 'package:expense_tracker/common/common_button.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onDelete,
  });
  final Expense expense;

  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
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
                              "Are you sure to delete!",
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
                        Lottie.asset('assets/json/delete.json'),
                        10.vGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CommonButton(
                              bgColor: Colors.transparent,
                              border: Border.all(
                                  width: 1, color: MyTheme.primaryColor),
                              onSubmit: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: MyTheme.primaryColor),
                              ),
                            )),
                            5.hGap,
                            Expanded(
                                child: CommonButton(
                              bgColor: MyTheme.primaryColor,
                              onSubmit: onDelete,
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Material(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: MyTheme.primaryColor,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(0, 1),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      searchExpenseIconBySlug(expense.expenseType ?? ""),
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                10.hGap,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ((expense.description?.isNotEmpty ?? false) &&
                                    (expense.description != null))
                                ? expense.description!
                                : "No Title",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            expense.createdAt != null
                                ? DateFormat.MMMMEEEEd()
                                    .format(expense.createdAt!)
                                : "",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                      4.vGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${NumberFormat("#,###").format(expense.amount ?? 0)} Ks",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            expense.createdAt != null
                                ? DateFormat('hh:ss a')
                                    .format(expense.createdAt!)
                                : "",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
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
