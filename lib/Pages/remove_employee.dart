import 'package:flutter/material.dart';

class RemoveEmployee extends StatefulWidget {
  const RemoveEmployee({super.key});

  @override
  State<RemoveEmployee> createState() => _RemoveEmployeeState();
}

class _RemoveEmployeeState extends State<RemoveEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
          ),
          const Text("Remove Employee Page"),
        ],
      ),
    );
  }
}