import 'package:businessmanagementsystem/Pages/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key,
      required this.username,
      required this.gender,
      required this.phone,
      required this.address,
      required this.orgName,
      required this.uid});
  final String username;
  final int phone;
  final String gender;
  final String address;
  final String orgName;
  final String uid;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _usernameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _orgNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _genderController = TextEditingController();

  
  void checkField(){
    String username, uid, orgName, address, gender,phone;
    uid = widget.uid;
    username = _usernameController.text.isEmpty?widget.username:_usernameController.text;
    orgName = _orgNameController.text.isEmpty?widget.orgName:_orgNameController.text;
    address = _genderController.text.isEmpty?widget.address:_genderController.text;
    gender = _genderController.text.isEmpty?widget.gender:_genderController.text;
    phone = _phoneNoController.text.isEmpty?"${widget.phone}":_phoneNoController.text;
    updateUser(uid, username, int.parse(phone), orgName, address, gender);
  }

  Future updateUser(String uid, String username, int phone, String orgName,
      String address, String gender) async {
    final collection = FirebaseFirestore.instance.collection("users");
    final doc = collection.doc(uid);
    try {
      await doc.update({
        'username': username,
        'phone': phone,
        'orgName': orgName,
        'address': address,
        'gender': gender
      }).then((value) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const Dashboard();
          },
        ));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Profile",
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
        body: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Editfield(
              labeltext: 'Username',
              hinttext: widget.username,
              cont: _usernameController),
          Editfield(
              labeltext: 'Gender',
              hinttext: widget.gender,
              cont: _genderController),
          Editfield(
              labeltext: 'Organization Name',
              hinttext: widget.orgName,
              cont: _orgNameController),
          Editfield(
              labeltext: 'Phone',
              hinttext: widget.phone.toString(),
              cont: _phoneNoController),
          Editfield(
              labeltext: 'Address',
              hinttext: widget.address,
              cont: _addressController),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: checkField,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF00BEF0),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            child: const Text(
              'Confirm Changes',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Editfield extends StatelessWidget {
  const Editfield({
    Key? key,
    required this.labeltext,
    required this.hinttext,
    required this.cont,
  }) : super(key: key);
  final String labeltext;
  final String hinttext;
  final TextEditingController cont;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labeltext,
            style: const TextStyle(
              fontSize: 15,
              //color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          TextField(
            controller: cont,
            decoration: InputDecoration(hintText: hinttext),
            style: TextStyle(
              color: Theme.of(context).unselectedWidgetColor,
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
