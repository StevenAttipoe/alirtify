import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alirtify/view/nav/Home.dart';
import 'package:alirtify/view/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            // key: _loginFormKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/icons/alirtify.png',
                  width: 200,
                  height: 200,
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
                    onPressed: () async => {
                      print(_passwordController.text.toString().trim()),
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text.toString().trim(),
                            password: _passwordController.text.toString().trim()),
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const Home()))
                      },
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(primary: Colors.black)),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Don't have an account? "),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: const Text('Sign up!'),
            )
          ])
        ],
      )),
    );
  }
}
