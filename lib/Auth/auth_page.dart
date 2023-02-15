import 'package:businessmanagementsystem/Pages/login_page.dart';
import 'package:businessmanagementsystem/Pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  //Initially, show the login page
  bool showLoginPage = true;

  void toggleScreens(){
    showLoginPage != showLoginPage;
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return const LoginPage();
    } else{
      return const RegisterPage();
    }
  }
}