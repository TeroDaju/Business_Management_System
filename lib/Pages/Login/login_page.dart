import 'package:businessmanagementsystem/Pages/Login/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../dashboard.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(error),
        );
      },
    );
  }

  Future logIn() async {
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const Dashboard())));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorDialog('Email not found');
      } else if (e.code == 'wrong-password') {
        errorDialog('Incorrect password');
      } else if (e.code == 'invalid-email') {
        errorDialog('Incorrect Email Format');
      } else {
        errorDialog(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                image: AssetImage("images/BG.png"), fit: BoxFit.cover),
          ),
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
                height: 500,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 251, 254),
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
                      height: 30,
                    ),
                    const Text(
                      " Login",
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
                      height: 50,
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
                      alignment: Alignment.bottomLeft,
                      height: 75,
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
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext login) {
                              return const ForgotPassword();
                            }),
                          );
                        },
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: Color(0xFF00BEF0),
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          logIn();
                        } else {
                          errorDialog('Please fill both fields');
                        }
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
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext login) {
                              return const RegisterPage();
                            }),
                          );
                        }, 
                      child: const Text(
                        'Create a new account',
                        style: TextStyle(
                          color: Color(0xFF00BEF0),
                          fontSize: 14,
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
