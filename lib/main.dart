import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

void main() {
  var standardColorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);
  var darkColorTheme =
      ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: const Color.fromARGB(255, 5, 99, 125));
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: darkColorTheme),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: standardColorScheme,
      ),
      themeMode: ThemeMode.dark,
      home: const Expenses(),
    ),
  );
}
