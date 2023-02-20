import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (context){
          return const AlertDialog(
            content: Text("Password Reset link has been sent! Check your email."),
          );
        }
      );
    } on FirebaseAuthException catch(e){
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
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
                height: 150,
              ),
              Container(
                width: 325,
                height: 250,
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
                    const Text(" Please enter the email of your account so \n that we can help you recover it",
                        style: TextStyle(
                        color: Color(0xFF00BEF0),
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(fillColor: Color(0xFF00BEF0)),
                      ),
                    ),
                    Container(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: passwordReset,
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
                        'Reset Password',
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
    );
  }
}
