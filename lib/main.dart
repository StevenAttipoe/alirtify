import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alirtify/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ' Alirtify',
      home:  SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// 894bdbb13d184421920e41ebeff2da35

// flutter run --no-sound-null-safety 