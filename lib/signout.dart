import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void signOutUser() async {
  await FirebaseAuth.instance.signOut();
}

class Signout extends StatefulWidget {
  const Signout({super.key});

  @override
  State<Signout> createState() => _SignoutState();
}

class _SignoutState extends State<Signout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            signOutUser();

            Navigator.pop(context);

            Fluttertoast.showToast(
                msg: 'Signed Out Successfully',
                backgroundColor: Colors.black38,
                textColor: Colors.amber,
                fontSize: 16,
                toastLength: Toast.LENGTH_SHORT);
          },
          child: const Text("Sign Out")),
    );
  }
}
