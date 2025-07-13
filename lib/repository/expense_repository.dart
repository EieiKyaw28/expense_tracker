import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ExpenseRepository {
  Stream<List<Expense>> getExpenseList(ExpenseFamilyModel? family) {
    if (family == null) {
      return isar.expenses
          .where()
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
    }

    final startDate = DateTime(family.year, family.month, 1);
    final endDate = DateTime(family.year, family.month + 1, 1)
        .subtract(const Duration(milliseconds: 1)); // end of the month

    final query = isar.expenses.filter().createdAtBetween(startDate, endDate);

    return query.sortByCreatedAtDesc().watch(fireImmediately: true);
  }

  Future<double> getTotalForMonth(int month, int year) async {
    final start = DateTime(year, month);
    final end = DateTime(year, month + 1);

    final expenses =
        await isar.expenses.filter().createdAtBetween(start, end).findAll();

    double total = expenses.fold(0.0, (sum, e) => sum + (e.amount ?? 0));

    return total;
  }

  Future<void> addExpense({
    required String description,
    required double amount,
    required String expenseType,
  }) async {
    try {
      final newCart = Expense()
        ..description = description
        ..amount = amount
        ..expenseType = expenseType
        ..createdAt = DateTime.now();

      log("Adding new expense : $description");

      await isar.writeTxn(() async {
        await isar.expenses.put(newCart);
      });
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Expense Error : $e $st");
    }
  }

  Future<void> deleteExpense(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.expenses.delete(id);
      });
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Expense Error : $e $st");
    }
  }
}
