import 'package:firebase_app/log/login.dart';
import 'package:firebase_app/log/signup.dart';
import 'package:firebase_app/screen/add.dart';
import 'package:firebase_app/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? Home()
            : login(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.orange[200],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange[500],
            titleTextStyle: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        routes: {
          'login': (context) => login(),
          'signup': (context) => signup(),
          'home': (context) => Home(),
          'add': (context) => add(),
        });
  }
}
