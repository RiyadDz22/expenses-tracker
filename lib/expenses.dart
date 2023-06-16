import 'package:expense_tracker/widgets/espenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpenses = [
    Expense(
        title: 'flutter course',
        amount: 20,
        date: DateTime.now(),
        catagory: Catagory.work),
    Expense(
        title: 'hot dog',
        amount: 1.99,
        date: DateTime.now(),
        catagory: Catagory.food)
  ];

  void _openAddExpense() {
    showModalBottomSheet(
        context: context,
        builder: ((ctx) {
          return const NewExpense();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('expenses tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(expenses: _registredExpenses),
          ),
        ],
      ),
    );
  }
}
