import 'package:flutter/material.dart';

class RecordExpenses extends StatefulWidget {
  const RecordExpenses({super.key});

  @override
  State<RecordExpenses> createState() => _RecordExpensesState();
}

class _RecordExpensesState extends State<RecordExpenses> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
        "Record Expenses"
      )
      ),
    );
  }
}