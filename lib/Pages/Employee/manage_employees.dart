import 'package:businessmanagementsystem/Pages/Employee/add_employee.dart';
import 'package:businessmanagementsystem/Pages/Employee/attendance.dart';
import 'package:businessmanagementsystem/Pages/Employee/edit_employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageEmployees extends StatefulWidget {
  const ManageEmployees({super.key});

  @override
  State<ManageEmployees> createState() => _ManageEmployeesState();
}

class _ManageEmployeesState extends State<ManageEmployees> {
  int _employeeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadEmployeeCount();
  }

  Future<void> _loadEmployeeCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('employees')
          .get();

      setState(() {
        _employeeCount = snapshot.size;
      });
    } catch (e) {
      //print('Error loading employee count: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Manage Employees",
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
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/employee.png"),
                  ),
                ),
          ),
          Container(
            alignment: Alignment.center,
            height: 385,
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
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 75,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 189, 189, 189),
                          blurRadius: 0.1,
                          offset: Offset(0, 1)),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "No. of Employees",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00AFEE),
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left:40),
                            child: Image.asset(
                              "images/manageEmployees.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left:15),
                            child: Text(
                              "$_employeeCount",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 270.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const AddEmployee();
                        }),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(50, 60)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/plus.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Add Employee",
                            style: TextStyle(
                              color: Color(0xFF00AFEE),
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 270.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const EditEmployee();
                        }),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(50, 60)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/edit.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "View/Edit Employees",
                            style: TextStyle(
                              color: Color(0xFF00AFEE),
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 270.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const Attendance();
                        }),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(50, 60)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/Attendance.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Attendance",
                            style: TextStyle(
                              color: Color(0xFF00AFEE),
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
