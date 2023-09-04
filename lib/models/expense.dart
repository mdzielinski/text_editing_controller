import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  get formattedDate {
    return formatter.format(date);
  }

  @override
  String toString() {
    return 'Expense{title: $title}';
  }
}

class ExpensesBucket {
  final List<Expense> expenses;
  final Category category;
  final double sum;

  ExpensesBucket({required this.expenses, required this.category})
      : sum = expenses.fold(0, (v, e) => v + e.amount);

  static List<ExpensesBucket> inBuckets(List<Expense> expenses, ) {
    List<ExpensesBucket> list = groupBy(expenses, (e) => e.category)
        .entries
        .map((e) => ExpensesBucket(expenses: e.value, category: e.key))
        .toList();
    return list;
  }

  @override
  String toString() {
    return 'ExpensesBucket{expenses: $expenses, category: $category, sum: $sum}';
  }
}
