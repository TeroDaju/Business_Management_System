import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late List<Map<String, dynamic>> employees;
  late List<bool> attendanceList;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('employees')
        .get();

    setState(() {
      employees = snapshot.docs.map((doc) => doc.data()).toList();
      attendanceList = List<bool>.filled(employees.length, false);
    });
  }

  Future<void> markAttendance(int index, bool isPresent) async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    final Map<String, dynamic> employee = employees[index];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('attendance')
        .add({
      'employeeName': employee['name'],
      'isPresent': isPresent,
      'timestamp': DateTime.now(),
    }).then((value) {
      setState(() {
        attendanceList[index] = isPresent;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully.')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to mark attendance. Please try again.')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Attendance",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 136, 231, 255),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          final bool isPresent = attendanceList[index];

          return ListTile(
            title: Text(employee['name']),
            subtitle: Text(employee['post']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isPresent ? 'Present' : 'Absent',
                  style: TextStyle(
                    color: isPresent ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () => markAttendance(index, true),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => markAttendance(index, false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Employee {
  final String id;
  final String name;

  Employee({
    required this.id,
    required this.name,
  });

  factory Employee.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Employee(
      id: snapshot.id,
      name: data['name'] ?? '',
    );
  }
}
