import 'package:businessmanagementsystem/Pages/Employee/manage_employees.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _nameController = TextEditingController();
  final _postController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  
Future addEmp() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    // add user details
    addEmployeeDetails(
            _nameController.text.trim(),
            _postController.text.trim(),
            _addressController.text.trim(),
            int.parse(_phoneController.text.trim()),
            uid)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ManageEmployees(),
          ));
    });
  }

  Future addEmployeeDetails(
      String name, String post, String address, int phone, String uid) async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('employees')
        .add({
      'name': name,
      'post': post,
      'address': address,
      'phone': phone,
      'uid': uid,
    }).then((value) => addAllDetails(name, post, address, phone));
  }

  Future addAllDetails(
      String name, String post, String address, int phone) async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('allEmp')
        .add({
      'name': name,
      'post': post,
      'address': address,
      'phone': phone,
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _postController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Employee",
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
                  image: AssetImage("images/addEmployee.png"),
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
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      "Name:",
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
                        controller: _nameController,
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
                      "Post:",
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
                        controller: _postController,
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
                      "Address:",
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
                        controller: _addressController,
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
                      "Phone Number:",
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
                        controller: _phoneController,
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
                        inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                          ],
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
                    child: ElevatedButton(
                      onPressed: addEmp,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50)),
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
                        'Enter',
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
    ));
  }
}