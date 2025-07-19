import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Budget {
  Id id = Isar.autoIncrement;

  double? income;
  DateTime? createdAt;
  List<Expense>? expenseList;

  Budget({
    this.id = Isar.autoIncrement,
    this.income,
    this.createdAt,
    this.expenseList,
  });

  Budget copyWith({
    Id? id,
    double? income,
    DateTime? createdAt,
    List<Expense>? expenseList,
  }) {
    return Budget(
      id: id ?? this.id,
      income: income ?? this.income,
      createdAt: createdAt ?? this.createdAt,
      expenseList: expenseList ?? this.expenseList,
    );
  }
}

@embedded
class Expense {
  double? amount;
  String? description;
  String? expenseType;

  DateTime? createdAt;

  Expense({
    this.amount,
    this.description,
    this.expenseType,
    this.createdAt,
  });

  Expense copyWith({
    double? amount,
    String? description,
    String? expenseType,
    DateTime? createdAt,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      expenseType: expenseType ?? this.expenseType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
