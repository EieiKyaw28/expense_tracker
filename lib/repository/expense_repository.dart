import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/domain/expense/expense_family_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ExpenseRepository {
  Stream<Budget> getExpenseList(ExpenseFamilyModel? family) {
    Stream<List<Budget>> budgetStream;

    if (family == null) {
      budgetStream = isar.budgets
          .where()
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
    } else {
      final startDate = DateTime(family.year, family.month, 1);

      final endDate =
          DateTime(family.year, family.month + 1, 0, 23, 59, 59, 999);

      final query = isar.budgets
          .filter()
          .createdAtBetween(startDate, endDate)
          .sortByCreatedAtDesc();

      budgetStream = query.watch(fireImmediately: true);
    }

    // return budgetStream.asyncExpand((list) => Stream.fromIterable(list));

    return budgetStream.map((list) {
      final budget = list.firstOrNull;
      if (budget != null) {
        /// sort expense list descending
        budget.expenseList?.sort((a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
      }
      return budget!;
    });
  }

  Future<double> getTotalForMonth(int month, int year) async {
    final start = DateTime(year, month);
    final end = DateTime(year, month + 1);

    final budgets =
        await isar.budgets.filter().createdAtBetween(start, end).findAll();

    double total = 0.0;

    for (final budget in budgets) {
      for (final expense in budget.expenseList ?? []) {
        total += expense.amount ?? 0;
      }
    }

    return total;
  }

  Future<void> addIncome({
    required double income,
    int? id,
  }) async {
    try {
      log("Income ID :: $id $income");
      final now = DateTime.now().toUtc();

      await isar.writeTxn(() async {
        Budget? budget;

        if (id != null) {
          budget = await isar.budgets.get(id);
        }

        if (budget != null) {
          budget.income = income;
        } else {
          budget = Budget()
            ..income = income
            ..createdAt = now
            ..expenseList = [];
        }

        await isar.budgets.put(budget);
      });

      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Budget Error (addIncome): $e\n$st");
    }
  }

  Future<void> addExpense({
    required String description,
    required double amount,
    required String expenseType,
  }) async {
    try {
      final now = DateTime.now().toUtc();
      final startOfMonth = DateTime(now.year, now.month);
      final endOfMonth = DateTime(now.year, now.month + 1);

      final newExpense = Expense()
        ..description = description
        ..amount = amount
        ..expenseType = expenseType
        ..createdAt = now;

      log("Adding new expense: $description $now");

      await isar.writeTxn(() async {
        Budget? budget = await isar.budgets
            .filter()
            .createdAtBetween(startOfMonth, endOfMonth)
            .findFirst();

        if (budget == null) {
          budget = Budget()
            ..createdAt = now
            ..income = 0.0
            ..expenseList = [newExpense];
        } else {
          final currentList = budget.expenseList ?? [];
          budget.expenseList = List<Expense>.from(currentList)..add(newExpense);
        }

        await isar.budgets.put(budget);
      });

      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Expense Error: $e\n$st");
    }
  }

  Future<void> deleteExpense({
    required int budgetId,
    required DateTime createdAt,
  }) async {
    try {
      await isar.writeTxn(() async {
        final budget = await isar.budgets.get(budgetId);

        if (budget == null) return;

        budget.expenseList?.removeWhere(
          (expense) => expense.createdAt == createdAt,
        );

        await isar.budgets.put(budget); // Save updated budget
      });

      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Expense Error (delete): $e\n$st");
    }
  }
}
