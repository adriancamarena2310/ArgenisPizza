import 'dart:async';
import 'package:argenis_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _primerNombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _fotoUrlController = BehaviorSubject<String>();
  

  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get paswordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get primerNombreStream => _passwordController;
  Stream<String> get apellidoStream => _emailController.stream;
  Stream<String> get fotoUrlStream => _passwordController.stream;

  // Combina los flujos de email y contraseña para determinar si el formulario es válido
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, paswordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePrimerNombre => _primerNombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeFotoUrl => _fotoUrlController.sink.add;

  //Obtener el ultimo valos ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get primerNombre => _primerNombreController.value;
  String get apellido => _apellidoController.value;
  String get fotoUrl => _fotoUrlController.value;


  // Limpiar los controladores al cerrar el bloc
  dispose() {
    _emailController.close();
    _passwordController.close();
    _primerNombreController.close();
    _apellidoController.close();
    _fotoUrlController.close();
  }
}
