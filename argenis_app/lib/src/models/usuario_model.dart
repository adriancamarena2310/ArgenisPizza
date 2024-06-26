import 'dart:convert';

// Funciones para convertir JSON a UsuarioModel y viceversa
UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));
String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  String? id;
  String primerNombre;
  String? apellido;
  String email;
  String password;
  String? fotoUrl;

  UsuarioModel({
    this.id,
    this.primerNombre = '',
    this.apellido,
    this.email = '',
    this.password = '',
    this.fotoUrl = '',
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        primerNombre: json["primerNombre"],
        apellido: json["apellido"],
        email: json["email"],
        password: json["password"],
        fotoUrl: json["fotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "primerNombre": primerNombre,
        "apellido": apellido,
        "email": email,
        "password": password,
        "fotoUrl": fotoUrl,
      };
}
