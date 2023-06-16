import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
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

    dispose() {
      _titleController.dispose();
      _amountController.dispose();
      super.dispose();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('title : '),
          ),
        ),
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
                print(selectedCatagory);
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
              onPressed: () {},
              child: const Text('save expense'),
            ),
          ],
        )
      ]),
    );
  }
}
