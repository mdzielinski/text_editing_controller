import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  Icon categoryIcon() {
    switch (expense.category) {
      case Category.food:
        return const Icon(Icons.fastfood);
      case Category.travel:
        return const Icon(Icons.flight_takeoff);
      case Category.leisure:
        return const Icon(Icons.theater_comedy);
      case Category.work:
        return const Icon(Icons.work);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(children: [
                  categoryIcon(),
                  const SizedBox(width: 4),
                  Text(expense.formattedDate)
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
