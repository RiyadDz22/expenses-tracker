import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/espenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: Theme.of(context).cardTheme.margin,
            ),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemove(expenses[index]);
            },
            child: ExpenseItem(expense: expenses[index]),
          )),
    );
  }
}
