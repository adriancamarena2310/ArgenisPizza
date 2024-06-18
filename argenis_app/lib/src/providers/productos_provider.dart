import 'dart:convert';
import 'dart:io';

import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider{

  //final String _url = "https://flutter-varios-3c06b-default-rtdb.firebaseio.com"; // Manuel
  final String _url = "https://flutter-varios-df7a9-default-rtdb.firebaseio.com";
  final _prefs = PreferenciasUsuario();

  Future<bool> crearProducto( ProductoModel producto) async {
    final url = "$_url/productos.json?auth=${_prefs.token}";

    try{
    final resp = await http.post(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    //print (decodedData);

    return true;
    }catch(error){
      return false;
    }
  }


  // ignore: non_constant_identifier_names
  Future<bool> EditarProducto( ProductoModel producto) async {
    final url = "$_url/productos/${producto.id}.json?auth=${_prefs.token}";
    try{
    final resp = await http.put(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    //print (decodedData);

    return true;
    }catch(error){
      return false;
    }
  }


  Future<List<ProductoModel>> cargarProductos () async {
    final url = "$_url/productos.json?auth=${_prefs.token}";
    try{
      final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    if(decodedData == null) return [];

    decodedData.forEach((id, prod) { 

      final prdTemp = ProductoModel.fromJson(prod);
      prdTemp.id = id;

      productos.add(prdTemp);

    });
    return productos;
    }catch(eror){
      return [];
    }
  }


  Future<int> borrarProducto(String id) async {
    final url = "$_url/productos/$id.json?auth=${_prefs.token}";
    try{
      final resp = await http.delete(Uri.parse(url));
      return 1;
    }catch(error){
      return 0;
    }
    
  }


  Future<String?> subirImagem( File imagen) async {

    final url = Uri.parse("https://api.cloudinary.com/v1_1/dboyernzs/image/upload?upload_preset=yzh2czkm");
    final mimeType = mime(imagen.path)?.split("/");

    final imageUploadRequest = http.MultipartRequest(
      "POST",
      url
    );

    final file = await http.MultipartFile.fromPath(
      "file",
      imagen.path,
      contentType: MediaType( mimeType![0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if( resp.statusCode != 200 && resp.statusCode != 201){
      return null;
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];
  }

}