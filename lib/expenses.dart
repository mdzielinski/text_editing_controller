import 'package:expense_tracker/widgets/category_bars.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 10,
        date: DateTime.now().subtract(const Duration(days: 10)),
        category: Category.leisure),
    Expense(
        title: 'Pizza',
        amount: 20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Cinema',
        amount: 10,
        date: DateTime.now().subtract(const Duration(days: 10)),
        category: Category.food),
  ];
  final List<Expense> _expensesTrash = [];

  void _onSave(Expense expense) {
    _validate(expense);
    setState(() {
      _expenses.add(expense);
    });
    Navigator.pop(context);
  }

  void _onDismiss(Expense expense) {
    int removedI = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
      _expensesTrash.add(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text('${expense.title} deleted')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _expenses.insert(removedI, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var mainContent = _expenses.isEmpty
        ? const Center(child: Text('No Expences here. Start addin some!'))
        : ExpensesList(_expenses, _onDismiss);

    var h = 200.0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text('Expenses: (${_expenses.length})'),
          SizedBox(
            width: double.infinity,
            height: h,
            child: BarPlot(buckets: ExpensesBucket.inBuckets(_expenses), parentHeight: h),
          ),
          Expanded(child: mainContent)
        ],
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.77,
        maxHeight: MediaQuery.of(context).size.height * 0.77,
      ),
      context: context,
      builder: (ctx) {
        return NewExpense(_onSave);
      },
    );
  }

  void _validate(Expense expense) {
    //   todo
  }
}
