import 'package:flutter/material.dart';

class RevenueHistory extends StatefulWidget {
  const RevenueHistory({super.key});

  @override
  State<RevenueHistory> createState() => _RevenueHistoryState();
}

class _RevenueHistoryState extends State<RevenueHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
        "Revenue History"
      )
      ),
    );
  }
}