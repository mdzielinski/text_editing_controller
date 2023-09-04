import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.save, {super.key});

  final void Function(Expense expense) save;

  @override
  State<NewExpense> createState() => _State();
}

class _State extends State<NewExpense> {
  DateTime _date = DateTime.now();
  final TextEditingController _title = TextEditingController();
  bool _titleValEnabled = false;
  final TextEditingController _amount = TextEditingController();
  bool _amountValEnabled = false;
  Category _category = Category.leisure;

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 15;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _title,
            textAlign: TextAlign.right,
            maxLength: 50,
            onEditingComplete: () {
              _titleValEnabled = true;
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
                errorText: (_titleValEnabled == true &&
                        _title.value.text.trim().isEmpty)
                    ? "Input title"
                    : null,
                hintText: 'Title',
                prefixText: '\$ '),
          ),
          Row(
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropdownButton(
                          value: _category,
                          items: Category.values
                              .map((c) => DropdownMenuItem(
                                  value: c, child: Text(c.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _category = value;
                            });
                          }),
                      verticalLine(spacing, context),
                      Expanded(
                        child: TextField(
                          controller: _amount,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          onEditingComplete: () {
                            _amountValEnabled = true;
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                              errorText: (_amountValEnabled == true &&
                                      double.tryParse(_amount.text) == null)
                                  ? "Input number"
                                  : null,
                              hintText: 'Amount',
                              prefixText: '\$ '),
                        ),
                      ),
                      SizedBox(
                        width: spacing,
                      ),
                      verticalLine(spacing, context),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _select,
                            icon: const Icon(Icons.edit_calendar),
                          ),
                          Text(formatter.format(_date)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text('Cancel'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  VerticalDivider verticalLine(double spacing, BuildContext context) {
    return VerticalDivider(
        width: spacing,
        indent: 2,
        thickness: 1,
        endIndent: 2,
        color: Theme.of(context).colorScheme.secondary);
  }

  void _select() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
        context: context,
        initialDate: _date.subtract(const Duration(days: 1)),
        firstDate: _date.subtract(const Duration(days: 30)),
        lastDate: now);
    setState(() {
      _date = selected ?? now;
    });
  }

  void _submitExpenseData() {
    widget.save(Expense(
        title: _title.value.text,
        amount: double.parse(_amount.text),
        date: _date,
        category: _category));
    FocusScope.of(context).unfocus();
    FocusScope.of(context).unfocus();
  }
}
