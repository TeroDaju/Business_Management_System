import 'package:flutter/material.dart';
import 'Login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/firstBG.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                height: 450,
              ),
              const Text(
                "      Your one stop to\n manage your business",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
              Container(
                height: 75,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext goToLogin) {
                      return const LoginPage();
                    }),
                  );
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 60)),
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
                  'Get Started',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
