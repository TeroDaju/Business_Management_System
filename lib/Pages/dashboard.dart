import 'package:businessmanagementsystem/Pages/Login/login_page.dart';
import 'package:businessmanagementsystem/Pages/Employee/manage_employees.dart';
import 'package:businessmanagementsystem/Pages/Revenue/manage_revenue.dart';
import 'package:businessmanagementsystem/Pages/Tasks/manage_tasks.dart';
import 'package:businessmanagementsystem/Pages/Profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //username to be used to greet the user
  String username = '';
  String gender = '';
  String orgName = '';
  int phone = 0;
  String address = '';
  String uid = '';

  Future _getUsername() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uid = snapshot.data()!["uid"];
          username = snapshot.data()!["username"];
          gender = snapshot.data()!["gender"];
          phone = snapshot.data()!["phone"];
          orgName = snapshot.data()!["orgName"];
          address = snapshot.data()!["address"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // This will prevent the user from navigating back
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/dashboard.png"), fit: BoxFit.cover),
            ),
            child: Column(children: [
              Container(
                height: 60,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 100,
                width: 325,
                child: Text(
                  "Hello,\n$username",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Container(
                height: 50,
              ),
              SizedBox(
                width: 300.0,
                height: 75.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext goToLogin) {
                        return const ManageRevenue();
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
                          "images/manageRevenue.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 35),
                        const Text(
                          "Manage Revenue",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 20,
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
              Container(
                height: 50,
              ),
              SizedBox(
                width: 300.0,
                height: 75.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext goToLogin) {
                        return const ManageEmployees();
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
                          "images/manageEmployees.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 35),
                        const Text(
                          "Manage Employees",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 20,
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
              Container(
                height: 50,
              ),
              SizedBox(
                width: 300.0,
                height: 75.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext goToLogin) {
                        return const ManageTasks();
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
                          "images/manageTasks.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 35),
                        const Text(
                          "Manage Tasks",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 20,
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
              Container(
                height: 100,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: 75.0,
                    height: 75.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext goToLogin) {
                            return Profile(
                                username: username,
                                address: address,
                                phone: phone,
                                gender: gender,
                                orgName: orgName,
                                uid: uid);
                          }),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(50, 60)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 255, 255),
                        ),
                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          "images/profile.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 175,
                  ),
                  SizedBox(
                    width: 75.0,
                    height: 75.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext goToLogin) {
                            return const LoginPage();
                          }),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(50, 60)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 255, 255),
                        ),
                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          "images/logOut.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
