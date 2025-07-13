import 'package:expense_tracker/constant/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalExpenseComponet extends StatelessWidget {
  const TotalExpenseComponet({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your's ${DateFormat.MMMM().format(DateTime.now())} Expense",
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          "${NumberFormat("#,###").format(totalAmount)} Ks",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        10.vGap,
        Divider(
          color: Colors.grey.withOpacity(.3),
        )
      ],
    );
  }
}
