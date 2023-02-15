import 'package:flutter/material.dart';

class ManageTasks extends StatefulWidget {
  const ManageTasks({super.key});

  @override
  State<ManageTasks> createState() => _ManageTasksState();
}

class _ManageTasksState extends State<ManageTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
          ),
          const Text("Manage Tasks Page"),
        ],
      ),
    );
  }
}