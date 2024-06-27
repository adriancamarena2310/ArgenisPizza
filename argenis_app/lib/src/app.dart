import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/screens/Admin_Screen.dart';
import 'package:argenis_app/src/screens/Carrito_Screen.dart' as carrito_screen;
import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';
import 'package:argenis_app/src/screens/Home_Tienda_Screen.dart';
import 'package:argenis_app/src/screens/Login_Screen.dart';
import 'package:argenis_app/src/screens/Preview_Screen.dart';
import 'package:argenis_app/src/screens/Producto_Screen.dart';
import 'package:argenis_app/src/screens/Profile_Screen.dart';
import 'package:argenis_app/src/screens/Register_Screen.dart';
import 'package:argenis_app/src/screens/ver_producto.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guillrmos coffee",
      initialRoute: "/",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 147, 91, 41),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 147, 91, 41),
        ),),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) => PreviewScreen(), // Prelogin
        "/login": (BuildContext context) => const LoginScreen(),
        "/register": (BuildContext context) => const RegisterScreen(),
        "/homeTienda": (BuildContext context) => const HomeTiendaScreem(),
        "/homeDomicilio": (BuildContext context) => const HomeDomicilioScreen(),
        "/profile": (BuildContext context) => EditProfileScreen(usuario: UsuarioModel()),
        "/producto": (BuildContext context) => const ProductoPage(),
        "/VerProducto": (BuildContext context) => const VerProductoScreen(),
        "/carrito": (BuildContext context) => carrito_screen.CarritoScreen(
          productos: const [], // Estos valores no se utilizarán, el propósito es solo registrar la ruta
          quantities: const [],
        ),
        "/adminhome": (BuildContext context) => AdminScreen(),
      },
    );
  }
}
