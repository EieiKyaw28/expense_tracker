// import 'package:expense_tracker/constant/my_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class DashboardCardPicker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyTheme.bgColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Dashboard Card Picker',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Period to Period Comparison',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'How am I doing versus the previous period, and the same period from last year?',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'LAST 30 DAYS',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'MMK 1,300.00',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TabButton(title: 'Cash Flow', isSelected: true),
//                           TabButton(title: 'Expenses', isSelected: false),
//                           TabButton(title: 'Income', isSelected: false),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       SizedBox(height: 200, child: LineChartWidget()),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Text(
//                               'ADD CARD TO DASHBOARD',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Cash Flow',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Am I spending less than I make?',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       SizedBox(height: 16),
//                       Container(
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           'Data shown here are only randomly generated.',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TabButton extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   const TabButton({required this.title, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         backgroundColor: isSelected ? Colors.blue : Colors.transparent,
//       ),
//       onPressed: () {},
//       child: Text(title),
//     );
//   }
// }

// class LineChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(show: false),
//         borderData: FlBorderData(show: false),
//         extraLinesData: ExtraLinesData(
//           horizontalLines: [
//             HorizontalLine(color: Colors.grey, y: 0, strokeWidth: 1),
//             HorizontalLine(color: Colors.grey, y: 1),
//             HorizontalLine(color: Colors.grey, y: 7),
//             HorizontalLine(color: Colors.grey, y: 3),
//             HorizontalLine(color: Colors.grey, y: 4),
//           ],
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 0),
//               FlSpot(1, 100),
//               FlSpot(2, -100),
//               FlSpot(3, 200),
//               FlSpot(4, 300),
//               FlSpot(5, 600),
//             ],
//             isCurved: true,
//             color: Colors.orange,
//             barWidth: 3,
//             isStrokeCapRound: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
