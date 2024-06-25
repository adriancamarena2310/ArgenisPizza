import 'dart:convert';
import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _url = "https://flutter-varios-df7a9-default-rtdb.firebaseio.com";
  final String _firebaseToken = "AIzaSyDs0Mq0nIGoIht-AQY0hOv4mIF8OTzfqLo";
  final _prefs = PreferenciasUsuario();
   
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      "email" : email,
      "password" : password,
      "returnSecureToken" : true
    };

    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    //print(decodedResp);

    if ( decodedResp.containsKey("idToken")){

      _prefs.token = decodedResp["idToken"];

      return { "ok": true, "token": decodedResp["idToken"] };
    }else{
      return { "ok": false, "mensaje": decodedResp["error"]["message"] };
    }
  }


  Future<bool> crearUsuario( UsuarioModel user) async {
    final url = "$_url/usuarios.json?auth=${_prefs.token}";

    try{
    final resp = await http.post(Uri.parse(url), body: UsuarioModelToJson(user));

    final decodedData = json.decode(resp.body);

    return true;
    }catch(error){
      return false;
    }
  }


   // ignore: non_constant_identifier_names
  Future<bool> EditarUsuario( UsuarioModel usuario) async {
    final url = "$_url/usuarios/${usuario.id}.json?auth=${_prefs.token}";
    try{
    final resp = await http.put(Uri.parse(url), body: UsuarioModelToJson(usuario));

    final decodedData = json.decode(resp.body);

    return true;
    }catch(error){
      return false;
    }
  }

  
  Future<UsuarioModel> cargarUsuario (String id) async {
    final url = "$_url/usuarios/$id.json?auth=${_prefs.token}";
    try{
      final resp = await http.get(Uri.parse(url));

    if (resp.statusCode != 200){
      throw Exception("No se pudo cargar el usuario");
    }
    
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final UsuarioModel usuario = UsuarioModel.fromJson(decodedData);

    if(decodedData == null) return UsuarioModel();

    return usuario;
    }catch(eror){
      return UsuarioModel();
    }
  }

    
  Future<Map<String, dynamic>> nuevoUsuario( String email, String password) async {

    final authData = {
      "email" : email,
      "password" : password,
      "returnSecureToken" : true
    };

    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    //print(decodedResp);

    if ( decodedResp.containsKey("idToken")){

    _prefs.token = decodedResp["idToken"];

      return { "ok": true, "token": decodedResp["idToken"] };
    }else{
      return { "ok": false, "mensaje": decodedResp["error"]["message"] };
    }
  }


  }
