// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

    String? id;
    String titulo;
    double valor;
    String? fotoUrl;
    String? descripcion;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor  = 0.0,
        this.fotoUrl,
        this.descripcion
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        fotoUrl    : json["fotoUrl"],
        descripcion: json["descripcion"]
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "titulo"     : titulo,
        "valor"      : valor,
        "fotoUrl"    : fotoUrl,
        "descripcion": descripcion
    };
}
