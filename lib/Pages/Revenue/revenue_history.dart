import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RevenueHistory extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RevenueHistory({Key? key});

  @override
  State<RevenueHistory> createState() => _RevenueHistoryState();
}

class _RevenueHistoryState extends State<RevenueHistory> {
  late String uid;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "See all Revenue",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('all')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              //print(data['which']);
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['type']),
                trailing: Text(
                  'Rs.${data['amount']}' '\n' '${data['date']}',
                  style: TextStyle(
                      color: data['which']
                          ? const Color(0xFF14FF00)
                          : const Color(0xFFF44336)),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
