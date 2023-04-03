import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit_employee_details.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({Key? key}) : super(key: key);

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  late String uid;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Employees",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('employees')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['post']),
                onTap: () {
                  // Navigate to the employee details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditEmployeeDetailsPage(document.id),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
