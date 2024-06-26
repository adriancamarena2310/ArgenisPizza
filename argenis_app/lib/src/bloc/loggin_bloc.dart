import 'dart:async';
import 'package:argenis_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _primerNombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _fotoUrlController = BehaviorSubject<String>();

  // Streams públicos para consumir los datos
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get primerNombreStream => _primerNombreController.stream;
  Stream<String> get apellidoStream => _apellidoController.stream;
  Stream<String> get fotoUrlStream => _fotoUrlController.stream;

  // Combinar streams para validar el formulario
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Métodos para cambiar los valores de los streams
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePrimerNombre => _primerNombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeFotoUrl => _fotoUrlController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.valueOrNull ?? '';
  String get password => _passwordController.valueOrNull ?? '';
  String get primerNombre => _primerNombreController.valueOrNull ?? '';
  String get apellido => _apellidoController.valueOrNull ?? '';
  String get fotoUrl => _fotoUrlController.valueOrNull ?? '';

  // Limpiar los controladores al cerrar el bloc
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _primerNombreController.close();
    _apellidoController.close();
    _fotoUrlController.close();
  }
}
