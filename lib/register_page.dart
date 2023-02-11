import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 30,
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
                      decoration:
                          const InputDecoration(fillColor: Color(0xFF00BEF0)),
                    ),
                  ),
                  Container(
                    height: 30,
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
                      decoration:
                          const InputDecoration(fillColor: Color(0xFF00BEF0)),
                    ),
                  ),
                  Container(
                    height: 30,
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
                      decoration:
                          const InputDecoration(fillColor: Color(0xFF00BEF0)),
                    ),
                  ),
                  Container(
                    height: 30,
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
                      decoration:
                          const InputDecoration(fillColor: Color(0xFF00BEF0)),
                    ),
                  ),
                  Container(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext login) {
                          return const LoginPage();
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
    );
  }
}
