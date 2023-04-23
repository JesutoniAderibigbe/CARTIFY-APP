import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_app/pages/welcomepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signUp() async {
      try {
        await auth.createUserWithEmailAndPassword(
            email: name.text.trim(), password: password.text.trim());
        const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => WelcomePage()));
        print("Account created for user with ${name.text}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Error'),
              content: const Text('There was an error signing up this user.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
          print('Error during signup: $e');
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text('There was an error signing up this user.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
        print('Error during signup: $e');
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("Sign Up Page")),
        body: GestureDetector(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 200,
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                      controller: firstname,
                      decoration: InputDecoration(
                        labelText: "First Name",
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
                      controller: lastname,
                      decoration: InputDecoration(
                        labelText: "Last Name",
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
                        signUp();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        child: const Center(
                            child: Text(
                          "SIGN UP",
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
          ),
        ));
  }
}
