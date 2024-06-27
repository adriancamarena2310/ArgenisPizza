import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:argenis_app/src/models/producto_model.dart';

class FavoritosModelScreen extends StatefulWidget {
  const FavoritosModelScreen({Key? key}) : super(key: key);

  @override
  _FavoritosModelScreenState createState() => _FavoritosModelScreenState();
}

class _FavoritosModelScreenState extends State<FavoritosModelScreen> {
  late SharedPreferences _prefs;
  List<ProductoModel> _favoritos = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavoritos();
  }

  void _loadFavoritos() {
    // Iterar sobre SharedPreferences para obtener todos los productos marcados como favoritos
    List<ProductoModel> favoritos = [];
    _prefs.getKeys().forEach((key) {
      if (key.startsWith('favorito_')) {
        bool esFavorito = _prefs.getBool(key) ?? false;
          String productId = key.replaceFirst('favorito_', '');
          ProductoModel producto = ProductoModel(
            id: productId, // Asegúrate de cargar el ID adecuadamente
            titulo: 'Producto $productId', // Cambia esto según tu modelo
            valor: 0.0, // Cambia esto según tu modelo
            descripcion: 'Descripción del producto $productId', // Cambia esto según tu modelo
            fotoUrl: null, // Cambia esto según tu modelo
          );
          favoritos.add(producto);
        
      }
    });

    setState(() {
      _favoritos = favoritos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos Favoritos'),
        backgroundColor: Colors.blue, // Color de tu preferencia
      ),
      body: ListView.builder(
        itemCount: _favoritos.length,
        itemBuilder: (context, index) {
          ProductoModel producto = _favoritos[index];
          return ListTile(
            title: Text(producto.titulo),
            subtitle: Text('Precio: \$${producto.valor.toStringAsFixed(2)}'),
            // Agrega más información si es necesario
          );
        },
      ),
    );
  }
}
