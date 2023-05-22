import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditTaskDetails extends StatefulWidget {
  final String taskId;
  const EditTaskDetails(this.taskId, {Key? key}) : super(key: key);

  @override
  State<EditTaskDetails> createState() => _EditTaskDetailsState();
}

class _EditTaskDetailsState extends State<EditTaskDetails> {
  late String uid;
  late TextEditingController titleController;
  late TextEditingController selectedEmployeeController;
  late TextEditingController remarksController;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    titleController = TextEditingController();
    selectedEmployeeController = TextEditingController();
    remarksController = TextEditingController();
    _loadTasksData();
  }

  @override
  void dispose() {
    titleController.dispose();
    selectedEmployeeController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  Future<void> _loadTasksData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(widget.taskId)
          .get();

      final data = snapshot.data() as Map<String, dynamic>;
      titleController.text = data['title'] ?? '';
      selectedEmployeeController.text = data['selectedEmployee'] ?? '';
      remarksController.text = data['remarks'] ?? '';
    } catch (e) {
      //print('Error loading employee data: $e');
    }
  }

  Future<void> _deleteTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(widget.taskId)
          .delete();

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting task: $e')),
      );
    }
  }

  Future<void> _saveTaskData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(widget.taskId)
          .set({
        'title': titleController.text.trim(),
        'selectedEmployee': selectedEmployeeController.text.trim(),
        'remarks': remarksController.text.trim(),
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task data saved')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving task data: $e')),
      );
    }
  }

  Future<void> _markAsDone() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(widget.taskId)
          .set({
        'title': titleController.text.trim(),
        'selectedEmployee': selectedEmployeeController.text.trim(),
        'remarks': remarksController.text.trim(),
        'status': 'Complete'
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task data saved')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving task data: $e')),
      );
    }
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
          IconButton(icon: const Icon(Icons.save), onPressed: _saveTaskData),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'title'),
                controller: titleController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'selectedEmployee'),
                controller: selectedEmployeeController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(labelText: 'remarks'),
                controller: remarksController,
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
                  onPressed: _deleteTask,
                  child: const Text('Delete Task'),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(50, 60)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF14FF00),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: _markAsDone,
                  child: const Text('Mark as Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
