import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();

    void login() async {
      try {
        await auth.signInWithEmailAndPassword(
            email: name.text.trim(), password: password.text.trim());
        const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
        print("Account created for user with ${name.text}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else {
          print('Error during login: $e');
        }
      } catch (e) {
        print('Error during signup: $e');
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: GestureDetector(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Username",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.always,
                    controller: password,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password can't be less than six characters";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: const Center(
                          child: Text(
                        "LOG IN",
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.black,
                          shape: BoxShape.rectangle),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
