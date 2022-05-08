import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alirtify/view/login.dart';

import '../model/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    initializeAppFirebase();
  }

  initializeAppFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Form(
            key: _signupFormKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/icons/alirtify.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Alirtify",
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bio',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_signupFormKey.currentState!.validate()) {
                        try {
                          await Firebase.initializeApp();
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          userSetup(
                            _emailController.text,
                            _nameController.text,
                            _bioController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(primary: Colors.black)),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Already have an account? "),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Log in!'),
            )
          ])
        ],
      )),
    );
  }
}
