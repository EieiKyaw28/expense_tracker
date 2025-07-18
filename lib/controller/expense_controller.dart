import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/domain/expense/expense_group_by_model.dart';
import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository expenseRepo;

  ExpenseController(this.expenseRepo);
  Budget budget = Budget();

  List<Expense> expenseList = <Expense>[];
  List<ExpenseGroupByModel> expenseGroupByList = <ExpenseGroupByModel>[];
  Map<int, double> monthlyTotals = <int, double>{};
  ExpenseFamilyModel? selectedFamily;

  @override
  void onInit() {
    super.onInit();
    fetchExpenses(family: selectedFamily);
    fetchExpensesGroupBy(family: selectedFamily);
  }

  Future<void> fetchExpenses({required ExpenseFamilyModel? family}) async {
    selectedFamily = family;
    expenseRepo.getExpenseList(family).listen((expense) {
      expenseList = expense.expenseList ?? [];
      budget = Budget(
        id: expense.id,
        income: expense.income,
        createdAt: expense.createdAt,
      );
      update();
    });
  }

  Future<void> fetchExpensesGroupBy(
      {required ExpenseFamilyModel? family}) async {
    selectedFamily = family;

    expenseRepo.getExpenseList(family).listen((expenses) {
      final Map<String, List<Expense>> grouped = {};

      for (final expense in expenses.expenseList ?? []) {
        final expenseDate = expense.createdAt!;

        // Calculate today and yesterday
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = today.subtract(const Duration(days: 1));
        final expenseDay =
            DateTime(expenseDate.year, expenseDate.month, expenseDate.day);

        String dateKey;
        if (expenseDay == today) {
          dateKey = "Today";
        } else if (expenseDay == yesterday) {
          dateKey = "Yesterday";
        } else {
          dateKey = DateFormat('yyyy-MM-dd').format(expenseDate);
        }

        grouped.putIfAbsent(dateKey, () => []);
        grouped[dateKey]!.add(expense);
      }

      expenseGroupByList = grouped.entries
          .map(
              (entry) => ExpenseGroupByModel(budget.id, entry.key, entry.value))
          .toList();

      // Optional: Custom sort: Today > Yesterday > rest by date descending
      expenseGroupByList.sort((a, b) {
        if (a.date == "Today") return -1;
        if (b.date == "Today") return 1;
        if (a.date == "Yesterday") return -1;
        if (b.date == "Yesterday") return 1;
        return b.date.compareTo(a.date);
      });

      update();
    });
  }

  Future<void> getTotalForMonth(int year) async {
    for (int month = 1; month <= 12; month++) {
      final total = await expenseRepo.getTotalForMonth(month, year);
      monthlyTotals[month] = total;
    }
    update();
  }

  Future<void> addExpense({
    required String description,
    required double amount,
    required String expenseType,
  }) async {
    await expenseRepo.addExpense(
      description: description,
      expenseType: expenseType,
      amount: amount,
    );
    fetchExpenses(family: selectedFamily);
  }

  Future<void> deleteExpense(int id, DateTime createdAt) async {
    await expenseRepo.deleteExpense(budgetId: id, createdAt: createdAt);
    fetchExpenses(family: selectedFamily);
  }
}
