import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEmployeeDetailsPage extends StatefulWidget {
  final String employeeId;

  const EditEmployeeDetailsPage(this.employeeId, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditEmployeeDetailsPageState createState() =>
      _EditEmployeeDetailsPageState();
}

class _EditEmployeeDetailsPageState extends State<EditEmployeeDetailsPage> {
  late String uid;
  late TextEditingController nameController;
  late TextEditingController postController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    nameController = TextEditingController();
    postController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    _loadEmployeeData();
  }

  @override
  void dispose() {
    nameController.dispose();
    postController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _loadEmployeeData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('employees')
          .doc(widget.employeeId)
          .get();

      final data = snapshot.data() as Map<String, dynamic>;
      nameController.text = data['name'] ?? '';
      postController.text = data['post'] ?? '';
      phoneController.text = data['phone'] ?? '';
      addressController.text = data['address'] ?? '';
    } catch (e) {
      print('Error loading employee data: $e');
    }
  }

  Future<void> _saveEmployeeData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('employees')
          .doc(widget.employeeId)
          .set({
        'name': nameController.text.trim(),
        'post': postController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee data saved')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving employee data: $e')),
      );
    }
  }

  Future<void> _deleteEmployee() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('employees')
          .doc(widget.employeeId)
          .delete();

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting employee: $e')),
      );
    }
  }

  Future<void> _confirmDeleteEmployee() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEmployee();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Details",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 136, 231, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveEmployeeData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: nameController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Post'),
              controller: postController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone'),
              controller: phoneController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Address'),
              controller: addressController,
            ),
            const SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(50, 60)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 60, 60),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                onPressed: _confirmDeleteEmployee,
                child: const Text('Delete Employee'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
