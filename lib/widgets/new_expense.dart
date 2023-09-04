import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _State();
}

class _State extends State<NewExpense> {
  DateTime _date = DateTime.now();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 15;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _name,
            textAlign: TextAlign.right,
            maxLength: 50,
            decoration: const InputDecoration(hintText: 'expense name'),
          ),
          Row(
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 300,
                        child: DropdownButton(
                            items: Category.values
                                .map((e) => DropdownMenuItem(
                                    child: Text(e.name.toString())))
                                .toList(),
                            onChanged: (value) {}),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _price,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '\$ amount', prefixText: '\$ '),
                        ),
                      ),
                      SizedBox(
                        width: spacing,
                      ),
                      VerticalDivider(
                          width: spacing,
                          indent: 2,
                          thickness: 1,
                          endIndent: 2,
                          color: Theme.of(context).colorScheme.secondary),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _select,
                            icon: Icon(Icons.edit_calendar),
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text('Cancel'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  print('name: ${_name.text}\n'
                      '\$: ${_price.text}');
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _select() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
        context: context,
        initialDate: _date.subtract(Duration(days: 1)),
        firstDate: _date.subtract(Duration(days: 30)),
        lastDate: now);
    setState(() {
      _date = selected ?? now;
    });
  }
}
