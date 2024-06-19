import 'package:argenis_app/src/app.dart';
import 'package:argenis_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(const MyApp());
}  
