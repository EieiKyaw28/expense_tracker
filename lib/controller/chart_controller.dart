import 'package:expense_tracker/domain/chart/chart_model.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChartController extends GetxController {
  final ExpenseRepository expenseRepo;

  ChartController(this.expenseRepo);

  RxList<ChartModel> expenseList = <ChartModel>[].obs;

  ExpenseFamilyModel? selectedFamily;

  @override
  void onInit() {
    super.onInit();
    fetchChartData(family: selectedFamily);
  }

  Future<void> fetchChartData({required ExpenseFamilyModel? family}) async {
    selectedFamily = family;

    expenseRepo.getExpenseList(family).listen((expenses) {
      // Filter current month's expenses
      final now = DateTime.now();
      final currentMonthExpenses = expenses.where((e) {
        return e.createdAt != null &&
            e.createdAt!.year == now.year &&
            e.createdAt!.month == now.month;
      }).toList();

      // Group by expenseType
      final Map<String, List<Expense>> grouped = {};
      for (var e in currentMonthExpenses) {
        if (e.expenseType == null) continue;
        grouped.putIfAbsent(e.expenseType!, () => []).add(e);
      }

      // Total amount for the month
      final double total = currentMonthExpenses.fold(
        0.0,
        (sum, e) => sum + (e.amount ?? 0),
      );

      // Build ChartModel list
      expenseList.value = grouped.entries.map((entry) {
        final type = entry.key;
        final groupTotal =
            entry.value.fold(0.0, (sum, e) => sum + (e.amount ?? 0));
        final percentage = total == 0 ? 0 : (groupTotal / total) * 100;

        return ChartModel(
          percentage: double.tryParse(percentage.toString()) ?? 0,
          image: searchExpenseIconBySlug(type), // optional function
          color: searchColorBySlug(type), // optional function
        );
      }).toList();

      update(); // notify UI
    });
  }
}
