import 'package:expense_tracker/widgets/chart/chart.dart';
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
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: ((ctx) {
          return NewExpense(_addExpense);
        }));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registredExpenses.indexOf(expense);
    setState(() {
      _registredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text(
          'Expense deleted',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Expense Found. Start adding some...'),
    );
    if (_registredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registredExpenses,
        onRemove: _removeExpense,
      );
    }
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
      body: width < 600
          ? Column(
              children: [
                Expanded(child: Chart(expenses: _registredExpenses)),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Chart(expenses: _registredExpenses),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
