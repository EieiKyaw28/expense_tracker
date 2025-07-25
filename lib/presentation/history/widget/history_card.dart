import 'package:expense_tracker/domain/month/month_model.dart';
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Container(
            width: 160,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    total,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
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
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 0,
          child: Container(
            width: 80,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: month.lightColor, //Colors.black.withValues(alpha: .2)
                offset: const Offset(3, 3),
                blurRadius: 3,
              ),
            ], color: month.darkColor, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                month.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
