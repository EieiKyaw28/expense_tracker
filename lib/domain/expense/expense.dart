import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  double? amount;

  String? description;
  String? expenseType;
  DateTime? createdAt;
}
