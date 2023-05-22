import 'package:businessmanagementsystem/Pages/Revenue/record_expenses.dart';
import 'package:businessmanagementsystem/Pages/Revenue/record_profits.dart';
import 'package:businessmanagementsystem/Pages/Revenue/revenue_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageRevenue extends StatefulWidget {
  const ManageRevenue({super.key});

  @override
  State<ManageRevenue> createState() => _ManageRevenueState();
}

class _ManageRevenueState extends State<ManageRevenue> {
  List<int> profit = [];
  List<int> expense = [];
  // List<String> profitType = [];
  // List<String> expenseType = [];
  int revenue = 0;

  @override
  void initState() {
    super.initState();
    getProfit();
  }

  void getProfit() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("profits")
        .get()
        .then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        profit.add(element.get("amount"));
      });
    }).then((value) => getExpense());
  }

  void getExpense() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("expenses")
        .get()
        .then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        expense.add(element.get("amount"));
      });
    }).then((value) => getRevenue());
  }

  void getRevenue() {
    int totalProfits = 0;
    int totalExpenses = 0;

    for (int i = 0; i < profit.length; i++) {
      totalProfits += profit[i];
    }

    for (int i = 0; i < expense.length; i++) {
      totalExpenses += expense[i];
    }

    setState(() {
      revenue = totalProfits - totalExpenses;
    });

  }

  // void getProfitType() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("expenses")
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       profitType.add(element.get("type"));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Manage Revenue",
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
                    image: AssetImage("images/revenue.png"),
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
                        "Financial Standing",
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
                            child: revenue>=0?Image.asset(
                              "images/manageRevenue.png",
                              width: 30,
                              height: 30,
                            ):Image.asset(
                              "images/negativeRevenue.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left:15),
                            child: Text(
                              "Rs.$revenue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: revenue>=0?const Color(0xFF14FF00):const Color(0xFFF44336),
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
                  width: 250.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const RecordProfit();
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
                            "images/profit.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Record Profits",
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
                  width: 250.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const RecordExpenses();
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
                            "images/expense.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Record Expenses",
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
                  width: 250.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const RevenueHistory();
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
                            "images/activity.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Check History",
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
