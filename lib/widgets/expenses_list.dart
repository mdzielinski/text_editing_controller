import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.onDismiss, {super.key});

  final void Function(Expense expense) onDismiss;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) {
        var valueKey = ValueKey(expenses[i]);
        var dismissible = Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.4),
              child: Icon(Icons.recycling),
            ),
            key: valueKey,
            child: ExpenseItem(expenses[i]),
            onDismissed: (direction) {
              onDismiss(expenses[i]);
            });
        return dismissible;
      },
    );
  }
}
