import 'package:expense_tracker/domain/expense/expense.dart';

class ExpenseGroupByModel {
  int id;
  String date;
  List<Expense> expense;
  ExpenseGroupByModel(this.id, this.date, this.expense);
}
