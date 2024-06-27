import 'dart:convert';
import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _url = "https://flutter-varios-df7a9-default-rtdb.firebaseio.com";
  final String _firebaseToken = "AIzaSyDs0Mq0nIGoIht-AQY0hOv4mIF8OTzfqLo";
  final _prefs = PreferenciasUsuario();
  List<UsuarioModel> _usuarios = []; // Lista local de usuarios (simulada)

  Future<Map<String, dynamic>> login(String email, String password) async {
  final authData = {
    "email": email,
    "password": password,
    "returnSecureToken": true
  };

  try {
    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey("idToken")) {
      // Guardar el token en las preferencias del usuario
      _prefs.token = decodedResp["idToken"];
      return { "ok": true, "token": decodedResp["idToken"] };
    } else {
      return { "ok": false, "mensaje": decodedResp["error"]["message"] };
    }
  } catch (error) {
    print("Error en la autenticación: $error");
    return { "ok": false, "mensaje": "Error en la autenticación" };
  }
}


  Future<bool> crearUsuario(UsuarioModel user) async {
    final url = "$_url/usuarios.json?auth=${_prefs.token}";

    try {
      final resp = await http.post(Uri.parse(url), body: usuarioModelToJson(user));
      final decodedData = json.decode(resp.body);
      return true;
    } catch (error) {
      return false;
    }
  }

  // Método para editar un usuario existente
Future<bool> EditarUsuario(UsuarioModel usuario) async {
  final url = "$_url/usuarios/${usuario.id}.json?auth=${_prefs.token}";

  try {
    final resp = await http.put(Uri.parse(url), body: usuarioModelToJson(usuario));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      return true;
    } else {
      print('Error en la edición del usuario: ${resp.statusCode}');
      return false;
    }
  } catch (error) {
    print('Error en la edición del usuario: $error');
    return false;
  }
}


  // Método para cargar un usuario por su ID
Future<UsuarioModel> cargarUsuario(String id) async {
  final url = "$_url/usuarios/$id.json?auth=${_prefs.token}";
  try {
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData == null) throw Exception("Usuario no encontrado");
      final UsuarioModel usuario = UsuarioModel.fromJson(decodedData);
      usuario.id = id; // Asignar el ID al usuario cargado
      return usuario;
    } else {
      throw Exception("Error al cargar el usuario");
    }
  } catch (error) {
    throw Exception("Error al cargar el usuario: $error");
  }
}


  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey("idToken")) {
      _prefs.token = decodedResp["idToken"];
      return { "ok": true, "token": decodedResp["idToken"] };
    } else {
      return { "ok": false, "mensaje": decodedResp["error"]["message"] };
    }
  }

  // Método para cerrar sesión
  Future<void> cerrarSesion() async {
    _prefs.token = '';
    // Aquí puedes añadir cualquier lógica adicional para cerrar sesión
  }

  // Método para buscar un usuario por email
  Future<UsuarioModel?> buscarUsuarioPorEmail(String email) async {
    // Simulación de búsqueda en una lista local de usuarios
    for (var usuario in _usuarios) {
      if (usuario.email == email) {
        return usuario;
      }
    }

    // Si no se encuentra localmente, buscar en la base de datos o servicio externo
    final url = "$_url/usuarios.json?auth=${_prefs.token}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Recorrer los datos recibidos para encontrar el usuario por email
        if (data != null) {
          for (var key in data.keys) {
            final usuario = UsuarioModel.fromJson(data[key]);
            if (usuario.email == email) {
              usuario.id = key; // Asignar el ID al usuario encontrado
              return usuario;
            }
          }
        }
      }
    } catch (error) {
      print("Error al buscar usuario por email: $error");
    }

    return null; // Retorna null si no se encuentra el usuario
  }
}
