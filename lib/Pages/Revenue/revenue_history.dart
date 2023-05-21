import 'package:businessmanagementsystem/Pages/Revenue/revenue_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RevenueHistory extends StatefulWidget {
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
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                  print(data['which']);
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['type']),
                trailing: Text(
                  'Rs.${data['amount']}' '\n' '${data['date']}',
                  style: TextStyle(
                    color: data['which']?const Color(0xFF14FF00):const Color(0xFFF44336)),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         centerTitle: true,
  //         title: const Text(
  //           "Revenue History",
  //           style: TextStyle(
  //             fontSize: 25,
  //             fontFamily: 'OpenSans',
  //             fontWeight: FontWeight.bold,
  //             letterSpacing: 0,
  //           ),
  //         ),
  //         elevation: 0,
  //         backgroundColor: const Color.fromARGB(255, 136, 231, 255),
  //       ),
  //       body: SafeArea(
  //         child: StreamBuilder(
  //           stream: FirebaseFirestore.instance
  //               .collection("users")
  //               .doc(FirebaseAuth.instance.currentUser!.uid)
  //               .collection("all")
  //               .snapshots(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const CircularProgressIndicator();
  //             } else if (snapshot.hasError) {
  //               return const Center(
  //                 child: Text("Something is wrong!"),
  //               );
  //             } else if (snapshot.data!.docs.isEmpty) {
  //               return const Center(
  //                 child: Text("No history available"),
  //               );
  //             }
  //             return ListView.builder(
  //               itemCount: snapshot.data!.docs.length,
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot docs = snapshot.data!.docs[index];
  //                 return Cards(title: docs["title"], func: (){}, which: docs["which"],);
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// class Cards extends StatelessWidget {
//   const Cards({super.key, required this.title, required this.func, required this.which});
//   final String title;
//   final VoidCallback func;
//   final bool which;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
//       child: Card(
//         color: const Color.fromARGB(255, 136, 231, 255),
//         elevation: 9,
//         shadowColor: Colors.teal[800],
//         child: ListTile(
//             title: Text(
//               title,
//               style: TextStyle(
//                 letterSpacing: 1.2,
//                 fontSize: 19,
//                 color: which?Colors.green:Colors.red,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//             onTap: func,
//             ),
//       ),
//     );
//   }
// }