import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNoController = TextEditingController();

  Future signUp() async{
    if (passwordConfirmed()){
      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      );

      final User user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;

      // add user details
      addUserDetails(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        int.parse(_phoneNoController.text.trim()),
        uid
        ).then((value){
          Navigator.of(context).pop();
             }
           );
    }
  }

  Future addUserDetails(String username, String email, int phone, String uid) async{
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'phone': phone,
        'uid' : uid,
      }
    );
  }

  bool passwordConfirmed(){
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _phoneNoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/BG.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/logo.png"),
                    ),
                  ),
                ),
                Container(
                  width: 325,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      Container(
                        height: 12,
                      ),
                      const Text(
                        " Register",
                        style: TextStyle(
                          color: Color(0xFF00BEF0),
                          fontSize: 30,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 700,
                        child: const Text(
                          "      Username",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          controller: _usernameController,
                          decoration:
                              const InputDecoration(fillColor: Color(0xFF00BEF0)),
                        ),
                      ),
                      Container(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 700,
                        child: const Text(
                          "      Password",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          obscureText: true, //to hide the input given by the user
                          controller: _passwordController,
                          decoration:
                              const InputDecoration(fillColor: Color(0xFF00BEF0)),
                        ),
                      ),
                      Container(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 700,
                        child: const Text(
                          "      Confirm Password",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          obscureText: true, //to hide the input given by the user
                          controller: _confirmPasswordController,
                          decoration:
                              const InputDecoration(fillColor: Color(0xFF00BEF0)),
                        ),
                      ),
                      Container(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 700,
                        child: const Text(
                          "      Email",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          controller: _emailController,
                          decoration:
                              const InputDecoration(fillColor: Color(0xFF00BEF0)),
                        ),
                      ),
                      Container(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 700,
                        child: const Text(
                          "      Phone No.",
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          controller: _phoneNoController,
                          decoration:
                              const InputDecoration(fillColor: Color(0xFF00BEF0)),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: signUp,
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
                          'Register',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
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
      ),
    );
  }
}
