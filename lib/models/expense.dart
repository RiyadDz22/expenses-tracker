import 'dart:ffi';

import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Catagory { food, travel, leisure, work }

const catagoryIcons = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.leisure: Icons.movie,
  Catagory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catagory})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catagory catagory;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.catagory, this.expenses);

  ExpenseBucket.forCatagory(List<Expense> allExpenses, this.catagory)
      : expenses = allExpenses
            .where((expense) => expense.catagory == catagory)
            .toList();

  final Catagory catagory;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
