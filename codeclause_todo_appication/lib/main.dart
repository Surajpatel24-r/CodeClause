import 'package:codeclause_todo_appication/screens/signUpScreen.dart';
import 'package:codeclause_todo_appication/screens/todoAddSceen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Service/Auth_Service.dart';
import 'screens/todoHomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth firebase_auth = FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpScreen();

  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = TodoHomeScreen();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentPage,
      title: "Todo",
    );
  }
}
