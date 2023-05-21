import 'package:flutter/material.dart';

class RevenueDetails extends StatelessWidget {
  final String title;
  final String details;

  const RevenueDetails({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(details),
      ),
    );
  }
}