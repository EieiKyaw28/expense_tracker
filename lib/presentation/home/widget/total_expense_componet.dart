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
          "Yours ${DateFormat.MMMM().format(DateTime.now())} Expense",
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          "${NumberFormat("#,###").format(totalAmount)} Ks",
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
