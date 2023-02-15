import 'package:businessmanagementsystem/Pages/login_page.dart';
import 'package:businessmanagementsystem/Pages/manage_employees.dart';
import 'package:businessmanagementsystem/Pages/manage_revenue.dart';
import 'package:businessmanagementsystem/Pages/manage_tasks.dart';
import 'package:businessmanagementsystem/Pages/profile.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // This will prevent the user from navigating back
      },
      child:  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/dashboard.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              height: 60,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 100,
              width: 325,
              child: const Text("Hello, \nUser",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 45,
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
                        MaterialPageRoute(builder: (BuildContext goToLogin) 
                            {
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
                              Image.asset("images/manageRevenue.png",
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
                        MaterialPageRoute(builder: (BuildContext goToLogin) 
                            {
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
                              Image.asset("images/manageEmployees.png",
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
                        MaterialPageRoute(builder: (BuildContext goToLogin) 
                            {
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
                              Image.asset("images/manageTasks.png",
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
                            MaterialPageRoute(builder: (BuildContext goToLogin) 
                                {
                            return const Profile();
                                }),
                              );
                            },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(const Size(50, 60)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                          ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset("images/profile.png",
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
                            MaterialPageRoute(builder: (BuildContext goToLogin) 
                                {
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
                            shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),

                          ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset("images/logOut.png",
                                    width: 30,
                                    height: 30,
                                  ),
                              ),
                            ),
                          ),
              ],
            ),
          ]
        ),
      ),
    ),
  );
  }
}
