import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'manage_revenue.dart';

class RecordExpenses extends StatefulWidget {
  const RecordExpenses({super.key});

  @override
  State<RecordExpenses> createState() => _RecordExpensesState();
}

class _RecordExpensesState extends State<RecordExpenses> {
  List<String> items = [
    'Rent',
    'Salaries',
    'Maintenance',
    'Supplies',
    'Advertising',
    'Legal Fees',
    'Others'
  ];
  String? type = 'Rent';
  //text controllers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();
  DateTime now = DateTime.now();

  Future recordExpenses() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    String date = "${now.year}/${now.month}/${now.day}-${now.hour}:${now.minute}";

    // add user details
    addExpensesDetails(
            _titleController.text.trim(),
            int.parse(_amountController.text.trim()),
            _remarksController.text.trim(),
            type!,
            uid,
            date)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ManageRevenue(),
          ));
    });
  }

  Future addExpensesDetails(
      String title, int amount, String remarks, String type, String uid, String date) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .add({
      'title': title,
      'amount': amount,
      'remarks': remarks,
      'type': type,
      'uid': uid,
      'date' : date,
    }).then((value) => addAllDetails(title, amount, remarks, type,date));
  }

  Future addAllDetails(
      String title, int amount, String remarks, String type,String date) async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('all')
        .add({
      'title': title,
      'amount': amount,
      'remarks': remarks,
      'type': type,
      'which': false,
      'date' : date,
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Record Expenses",
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
                    image: AssetImage("images/recordExpenses.png"),
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
                        "Amount:",
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
                          controller: _amountController,
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
                            FilteringTextInputFormatter.allow(RegExp(r'\d+')),
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
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Container(
                      height: 57,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: DropdownButtonFormField<String>(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        value: type,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                )))
                            .toList(),
                        onChanged: (item) => setState(() => type = item),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 0),
                      child: ElevatedButton(
                        onPressed: recordExpenses,
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
      ),
    );
  }
}
