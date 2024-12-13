import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/signout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final List<String> filter = ['Login', 'Signup'];
  late String selectionData;

  late final TextEditingController textController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    selectionData = filter[0];

    textController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1, color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectionData = filter[0];
                  });
                },
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text(
                      filter[0],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const SizedBox(
                height: 40,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectionData = filter[1];
                  });
                },
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text(
                      filter[1],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextField(
                  controller: textController,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      hintText: 'Eg. jayesh@gmail.com',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.amber)),
                  onPressed: () async {
                    String message = '';

                    if (selectionData == filter[1]) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: textController.text.trim(),
                                password: passwordController.text.trim());

                        message = 'Account Created Successfully';

                        Fluttertoast.showToast(
                            msg: message,
                            backgroundColor: Colors.black38,
                            textColor: Colors.amber,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 16,
                            gravity: ToastGravity.BOTTOM);

                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signout()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          message = "the password is too weak";
                        } else if (e.code == "email-already-in-use") {
                          message = "the email is already in use";
                        }

                        Fluttertoast.showToast(
                            msg: message,
                            backgroundColor: Colors.black38,
                            textColor: Colors.amber,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 16,
                            gravity: ToastGravity.BOTTOM);
                      } catch (e) {
                        throw Exception(e);
                      }
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: textController.text,
                            password: passwordController.text);

                        message = 'Account Logged In Succesfully';

                        Fluttertoast.showToast(
                            msg: message,
                            backgroundColor: Colors.black38,
                            textColor: Colors.amber,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 16,
                            gravity: ToastGravity.BOTTOM);
                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signout()));
                        }
                      } on FirebaseAuthException {
                        Fluttertoast.showToast(
                            msg:'Wrong Credentials',
                            backgroundColor: Colors.black38,
                            textColor: Colors.amber,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 16,
                            gravity: ToastGravity.BOTTOM);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'nothing to show',
                            backgroundColor: Colors.black38,
                            textColor: Colors.amber,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 16,
                            gravity: ToastGravity.BOTTOM);
                      }
                    }
                  },
                  child: Text(
                    selectionData,
                    style: const TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
