import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/domain/month/month_model.dart';
import 'package:expense_tracker/presentation/history/history_page.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.total,
    required this.month,
    required this.onTap,
  });
  final String total;
  final MonthModel month;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: month.darkColor,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: month.darkColor,
                ),
                4.hGap,
                Text(
                  month.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: month.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            14.vGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  total,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: month.darkColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
