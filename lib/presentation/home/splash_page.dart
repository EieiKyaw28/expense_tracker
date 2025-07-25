import 'dart:async';
import 'dart:ui';

import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<double> amounts = [
  500,
  1500,
  2000,
  3000,
  4500,
  5000,
  6000,
  9000,
  10000
];

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    final drawerController = Get.find<ZoomDrawerGetXController>();

    Timer(const Duration(seconds: 5), () {
      drawerController.changePage('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9EF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
        child: Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Graph
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaint(
                painter: CurvedStartLineGraphPainter(amounts),
                child: Center(), // For layout only
              ),
            ),

            // Title and Subtitle
            const Positioned(
              top: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '💰 NO 1 IN PRODUCT HUNT',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.green,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  Text(
                    'Your Smart\nMoney Manager!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Track your spending, make budgeting\n'
                    'effortless, and crush your savings\n'
                    'goals – All in one place.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 280,
              right: 40,
              child: _animatedIcon(
                name: 'food',
                icon: MyImage.food,
              ),
            ),
            Positioned(
              bottom: 240,
              right: 100,
              child: _animatedIcon(
                name: 'other',
                icon: MyImage.expenseIcon,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: _animatedIcon(
                name: 'education',
                icon: MyImage.education,
              ),
            ),
            Positioned(
              bottom: 150,
              right: 50,
              child: _animatedIcon(
                name: 'transporation',
                icon: MyImage.transporation,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: _animatedIcon(
                name: 'education',
                icon: MyImage.education,
              ),
            ),
            Positioned(
              bottom: 50,
              right: 100,
              child: _animatedIcon(
                name: 'bill',
                icon: MyImage.bill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedIcon({
    required String name,
    required String icon,
  }) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;
          return Transform.translate(
              offset: Offset(0, 10 * value),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: searchColorBySlug(name),
                        width: 2,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .2),
                          offset: const Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Center(
                      child: Image.asset(
                        icon,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

class CurvedStartLineGraphPainter extends CustomPainter {
  final List<double> amounts;

  CurvedStartLineGraphPainter(this.amounts);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = MyTheme.primaryColor
      ..strokeWidth = 5;

    final double spacing = size.width / (amounts.length - 1);
    final double maxAmount =
        amounts.isEmpty ? 0 : amounts.reduce((a, b) => a > b ? a : b);

    // amounts.reduce(max);

    final double heightScale = size.height / maxAmount;

    final Path path = Path();

    for (int i = 0; i < amounts.length; i++) {
      double x = i * spacing;
      double y = size.height - (amounts[i] * heightScale);

      if (i == 0) {
        // Start with a curve at the beginning
        final control = Offset(x - 40, y + 60); // pull curve downward left
        final start = Offset(x, y);
        path.moveTo(x - 80, y + 80); // far left point
        path.quadraticBezierTo(control.dx, control.dy, start.dx, start.dy);
      } else {
        path.lineTo(x, y);
      }

      // Draw dot
      canvas.drawCircle(Offset(x, y), 10, dotPaint);

      // Draw label
      final textSpan = TextSpan(
        text: '\$${amounts[i].toInt()}',
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 30, y - 25));
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
