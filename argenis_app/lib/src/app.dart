import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';
import 'package:argenis_app/src/screens/Login_Screen.dart';
import 'package:argenis_app/src/screens/Preview_Screen.dart';
import 'package:argenis_app/src/screens/Profile_Screen.dart';
import 'package:argenis_app/src/screens/Register_Screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ArgenisPizza",
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context ) => PreviewScreen(),//prelogin
        "/login": (BuildContext context ) => const LoginScreen(),
        "/register": (BuildContext context ) => const RegisterScreen(),
        "/homeTienda": (BuildContext context ) => const HomeDomicilioScreen(),
        "/homeDomicilio": (BuildContext context ) => const HomeDomicilioScreen(),
        "/profile": (BuildContext context ) => const ProfileScreen(),
      },
    );
  }
}