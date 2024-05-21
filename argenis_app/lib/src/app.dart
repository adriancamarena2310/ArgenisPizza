import 'package:argenis_app/src/screens/Home_Screen.dart';
import 'package:argenis_app/src/screens/Login_Screen.dart';
import 'package:argenis_app/src/screens/Preview_Screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ArgenisPizza",
      initialRoute: "/",
      routes: {
        "/": (BuildContext context ) => const PreviewScreen(),//prelogin
        "/login": (BuildContext context ) => const LoginScreen(),
        "/home": (BuildContext context ) => const HomeScreen()
      },
    );
  }
}