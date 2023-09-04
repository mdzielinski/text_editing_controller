import 'dart:math';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class BarPlot extends StatelessWidget {
  BarPlot({super.key, required this.buckets, required this.parentHeight})
      : _maxAmount = buckets
            .expand((ExpensesBucket e) => e.expenses)
            .map((e) => e.amount)
            .reduce((v, e) => max(v, e));

  final double parentHeight;
  final List<ExpensesBucket> buckets;
  final double _maxAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...buckets.map((ExpensesBucket b) {
          double barH = (parentHeight - 50) * ((b.sum / _maxAmount) / 4);
          print('parentHeight : $parentHeight');
          print('b.sum : ${b.sum}');
          print('_maxAmount : $_maxAmount');
          print('barH : $barH');
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 60,
                  height: barH,
                  child: ColoredBox(
                    color: Colors.red,
                    child: Center(child: Text('\$${b.sum}')),
                  ),
                ),
                SizedBox(
                  child: Text(b.category.name),
                  height: 30,
                ),
              ],
            ),
          );
        })
      ],
    );
  }

  maximum(double amount, double amount2) {
    return max(amount, amount2);
  }
}
