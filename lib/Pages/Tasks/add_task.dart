// ignore_for_file: depend_on_referenced_packages

import 'package:businessmanagementsystem/Pages/Tasks/manage_tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String uid;
  final format = DateFormat("yyyy-MM-dd");
  DateTime? selectedDate;
  String? selectedEmployee;

  //text controllers
  final _titleController = TextEditingController();
  final _remarksController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
  }

  Stream<QuerySnapshot> getEmployeesStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('employees')
        .snapshots();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> addTask() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    String date =
        "${now.year}/${now.month}/${now.day}-${now.hour}:${now.minute}";

    // Add employee details
    await addTaskDetails(
      _titleController.text.trim(),
      _remarksController.text.trim(),
      date,
      selectedEmployee!,
      uid,
    );

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ManageTasks(),
      ),
    );
  }

  Future<void> addTaskDetails(
    String title,
    String remarks,
    String date,
    String selectedEmployee,
    String uid,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .add({
      'title': title,
      'remarks': remarks,
      'date': date,
      'selectedEmployee': selectedEmployee,
      'uid': uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add Task",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/addTask.png"),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 450,
                width: 325,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 231, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Text(
                        "Title:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'^[0-9\s]{1}$')),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Text(
                        "Deadline:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child: SizedBox(
                        height: 40,
                        child: DateTimeField(
                          format: format,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            final currentDate = DateTime.now();
                            final initialDate = currentValue ?? currentDate;
                            return showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: currentDate,
                              lastDate: DateTime(2100),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Text(
                        "Remarks:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _remarksController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'^[0-9\s]{1}$')),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 57,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getEmployeesStream(uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final employees = snapshot.data!.docs;

                            return DropdownButtonFormField<String>(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              value: selectedEmployee,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedEmployee = value!;
                                });
                              },
                              items: employees.map((DocumentSnapshot document) {
                                final employee =
                                    document.data() as Map<String, dynamic>;
                                final employeeName = employee['name'];

                                return DropdownMenuItem<String>(
                                  value: employeeName,
                                  child: Text(employeeName),
                                );
                              }).toList(),
                              // Add your desired decoration and style properties here
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 0),
                      child: ElevatedButton(
                        onPressed: addTask,
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(200, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF00BEF0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Add and Allocate',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
