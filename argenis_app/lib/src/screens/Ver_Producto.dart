import 'package:argenis_app/src/models/favoritos_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:argenis_app/src/models/producto_model.dart';
// Importa la pantalla de favoritos

class VerProductoScreen extends StatefulWidget {
  const VerProductoScreen({Key? key}) : super(key: key);

  @override
  _VerProductoScreenState createState() => _VerProductoScreenState();
}

class _VerProductoScreenState extends State<VerProductoScreen> {
  ProductoModel producto = ProductoModel();
  bool _favorito = false; // Estado del botón de favorito
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavoritoState();
  }

  void _toggleFavorito() {
    setState(() {
      _favorito = !_favorito;
      _saveFavoritoState(_favorito);
    });
  }

  void _loadFavoritoState() {
    setState(() {
      _favorito = _prefs.getBool('favorito_${producto.id}') ?? false;
    });
  }

  void _saveFavoritoState(bool value) {
    _prefs.setBool('favorito_${producto.id}', value);
  }

  void _verFavoritos() {
    // Navegar a la pantalla de favoritos solo si el producto es favorito
    if (_favorito) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoritosModelScreen()),
      );
    } else {
      // Aquí puedes mostrar un mensaje o alguna acción si el producto no es favorito
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Producto no Favorito'),
          content: Text('Marca este producto como favorito para verlo en favoritos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductoModel? prodData = ModalRoute.of(context)?.settings.arguments as ProductoModel?;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.titulo, style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 122, 64, 24),

      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/assets/granos.gif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _mostrarFoto(),
                SizedBox(height: 20),
                Text(
                  producto.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Precio: \$${producto.valor.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Descripción: ${producto.descripcion ?? ""}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            image: NetworkImage(producto.fotoUrl!),
            placeholder: const AssetImage("images/assets/fondoPreview.gif"),
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'images/users/image.jpg',
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
