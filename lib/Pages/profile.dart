import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile(
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
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 136, 231, 255),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      color: const Color.fromARGB(255, 136, 231, 255),
                      height: 150,
                    ),
                  ),
                  const Positioned(
                    top: 100,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("images/defaultProfile.png"),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Details(title: 'Username', value: widget.username),
              Details(title: 'Gender', value: widget.gender),
              Details(title: 'Organization Name', value: widget.orgName),
              Details(title: 'Phone Number', value: widget.phone.toString()),
              Details(title: 'Address', value: widget.address),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext goToLogin) {
                      return EditProfile(
                        username: widget.username,
                        gender: widget.gender,
                        orgName: widget.orgName,
                        phone: widget.phone,
                        address: widget.address,
                        uid: widget.uid,
                      );
                    }),
                  );
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(150, 50)),
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
                  'Edit Profile',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 118, 112, 112),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 2.0,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        )
      ],
    );
  }
}
