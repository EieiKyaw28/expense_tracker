import 'package:expense_tracker/domain/expense/expense.dart';

class ExpenseGroupByModel {
  String date;
  List<Expense> expense;
  ExpenseGroupByModel(this.date, this.expense);
}
