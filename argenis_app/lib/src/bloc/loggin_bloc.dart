import 'dart:async';
import 'package:argenis_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  

  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get paswordStream => _passwordController.stream.transform(validarPassword);

  // Combina los flujos de email y contraseña para determinar si el formulario es válido
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, paswordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valos ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;


  // Limpiar los controladores al cerrar el bloc
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
