import 'package:firebase_login/login_card.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Firebase Authentication"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: const Color.fromARGB(255, 223, 221, 236),
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 350,
              child: LoginCard(),
            )
          ],
        ),
      ),
    );
  }
}
