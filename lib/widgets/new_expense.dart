import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  Catagory selectedCatagory = Catagory.leisure;

  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final entredAmount = double.tryParse(_amountController.text);
    final invalidAmount = entredAmount == null || entredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('invalid input'),
          content: const Text('please make sure that all your  input is valid'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: entredAmount,
          date: selectedDate!,
          catagory: selectedCatagory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: ((context, constraints) {
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('title : '),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('amount : '),
                            hintText: '9.99',
                            prefixText: '\$',
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('title : '),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: selectedCatagory,
                        items: Catagory.values
                            .map(
                              (catagory) => DropdownMenuItem(
                                value: catagory,
                                child: Text(
                                  catagory.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCatagory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selectedDate == null
                                  ? 'no date selected'
                                  : formatter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: datePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('amount : '),
                            hintText: '9.99',
                            prefixText: '\$',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selectedDate == null
                                  ? 'no date selected'
                                  : formatter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: datePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('save expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: selectedCatagory,
                        items: Catagory.values
                            .map(
                              (catagory) => DropdownMenuItem(
                                value: catagory,
                                child: Text(
                                  catagory.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCatagory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('save expense'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
