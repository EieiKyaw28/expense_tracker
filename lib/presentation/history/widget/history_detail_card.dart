import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/presentation/history/history_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDetailCard extends StatelessWidget {
  const HistoryDetailCard({
    super.key,
    required this.expense,
    required this.month,
  });
  final Expense expense;
  final MonthModel month;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: month.darkColor,
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
                  // color: month.darkColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    searchExpenseIconBySlug(expense.expenseType ?? 'other'),
                    height: 16,
                    width: 16,
                    color: month.darkColor,
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
                              ? DateFormat('hh:ss a').format(expense.createdAt!)
                              : "",
                          textAlign: TextAlign.end,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
    );
  }
}
