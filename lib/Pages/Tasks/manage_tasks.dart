import 'package:businessmanagementsystem/Pages/Tasks/add_task.dart';
import 'package:businessmanagementsystem/Pages/Tasks/edit_task.dart';
import 'package:flutter/material.dart';

class ManageTasks extends StatefulWidget {
  const ManageTasks({super.key});

  @override
  State<ManageTasks> createState() => _ManageTasksState();
}

class _ManageTasksState extends State<ManageTasks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Manage Tasks",
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
                    image: AssetImage("images/tasks.png"),
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
                        "No. of Tasks",
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
                              "images/noTasks.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left:15),
                            child: Text(
                              "0",
                              //"$_employeeCount",
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
                  height: 40,
                ),
                SizedBox(
                  width: 270.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const AddTask();
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
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/plus.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            "Add and Allocate Tasks",
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
                  height: 40,
                ),
                SizedBox(
                  width: 270.0,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext goToLogin) {
                          return const EditTask();
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
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/edit.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "View/Edit Tasks",
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