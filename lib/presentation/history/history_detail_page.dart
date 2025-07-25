import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_image.dart';

import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/domain/month/month_model.dart';
import 'package:expense_tracker/presentation/history/expense_type_pie_chart.dart';
import 'package:expense_tracker/presentation/history/widget/history_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

List<HistoryDetailModel> _tab = [
  HistoryDetailModel(image: MyImage.listIcon, title: "List"),
  HistoryDetailModel(image: MyImage.chartIcon, title: "Chart")
];

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({
    super.key,
    required this.month,
    required this.monthIndex,
  });
  final MonthModel month;
  final int monthIndex;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ExpenseController>().fetchExpenses(
        family: ExpenseFamilyModel(
          month: widget.monthIndex,
          year: 2025,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return CommonScaffold(
      appBar: CommonAppBar(
        hasDrawer: false,
        title: Text(
          "2025, ${widget.month.name} History",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerOnTap: () {
          drawerController.toggleDrawer();
        },
      ),
      body: GetBuilder<ExpenseController>(
        builder: (expenseController) {
          final expenses = expenseController.expenseList;
          return expenses.isEmpty
              ? Center(child: Lottie.asset('assets/json/empty_data.json'))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            children: List.generate(
                              _tab.length,
                              (index) {
                                return Expanded(
                                  child: TabButton(
                                    color: widget.month.darkColor,
                                    image: _tab[index].image,
                                    title: _tab[index].title,
                                    onTap: () {
                                      selectedIndex = index;
                                      setState(() {});
                                    },
                                    isSelected: selectedIndex == index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      10.vGap,
                      selectedIndex == 0
                          ? Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) => 8.vGap,
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  return HistoryDetailCard(
                                    expense: expenses[index],
                                    month: widget.month,
                                  );
                                },
                              ),
                            )
                          : Column(
                              children: [
                                const ExpenseTypePieChart(),
                                Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Expense Types',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        10.vGap,
                                        GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 40,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                              childAspectRatio: 1.0,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: commonExpenseList.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  commonExpenseList[index];
                                              return Row(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            searchColorBySlug(
                                                                item.slug),
                                                        width: 2,
                                                      ),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withValues(
                                                                  alpha: .2),
                                                          offset: const Offset(
                                                              3, 3),
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: Center(
                                                      child: Image.asset(
                                                        item.image,
                                                      ),
                                                    ),
                                                  ),
                                                  10.hGap,
                                                  // Image.asset(
                                                  //   item.image,
                                                  //   height: 30,
                                                  //   width: 30,
                                                  //   color: searchColorBySlug(item.slug),
                                                  // ),
                                                  // 10.hGap,
                                                  Text(
                                                    item.title,
                                                  )
                                                ],
                                              );
                                            }),
                                        16.vGap,
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: widget.month.darkColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'You can analyze which expense type is most frequently used.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  final Color color;
  final String image;
  const TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected ? color : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 16,
                  width: 16,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                4.hGap,
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryDetailModel {
  String image;
  String title;
  HistoryDetailModel({
    required this.image,
    required this.title,
  });
}
