import 'package:alirtify/view/nav/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alirtify/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToLogin();
    WidgetsFlutterBinding.ensureInitialized();
    initializeAppFirebase();
  }

 initializeAppFirebase() async {
    await Firebase.initializeApp();
  }

 _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/alirtify.png',
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
          ),
          const CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            color: Color.fromARGB(255, 170, 170, 170),
          )
        ],
      )),
    );
  }
}
