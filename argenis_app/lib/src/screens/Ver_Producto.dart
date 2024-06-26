import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:argenis_app/src/models/producto_model.dart';

class VerProductoScreen extends StatefulWidget {
  const VerProductoScreen({Key? key}) : super(key: key);

  @override
  _VerProductoScreenState createState() => _VerProductoScreenState();
}

class _VerProductoScreenState extends State<VerProductoScreen> {
  ProductoModel producto = ProductoModel();
  int _cantidad = 0;
  bool _favorito = false; // Estado del botón de favorito

  @override
  void initState() {
    super.initState();
    _loadFavoritoState();
  }

  void _incrementarCantidad() {
    setState(() {
      if (_cantidad < 20) _cantidad++;
    });
  }

  void _reducirCantidad() {
    setState(() {
      if (_cantidad > 0) _cantidad--;
    });
  }

  void _toggleFavorito() {
    setState(() {
      _favorito = !_favorito;
      _saveFavoritoState(_favorito);
    });
  }

  void _loadFavoritoState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorito = prefs.getBool('favorito_${producto.id}') ?? false;
    });
  }

  void _saveFavoritoState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorito_${producto.id}', value);
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
        actions: [
          IconButton(
            icon: Icon(
              _favorito ? Icons.star : Icons.star_border,
              color: _favorito ? Colors.amber : Colors.grey[400],
            ),
            onPressed: _toggleFavorito,
          ),
        ],
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción para agregar el producto
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                  ),
                  child: Text(
                    'Agregar',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(164, 225, 108, 5),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _reducirCantidad,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(40, 40),
                      ),
                      child: Text('-', style: TextStyle(fontSize: 30, color: Color.fromARGB(164, 225, 108, 5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '$_cantidad',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(164, 225, 108, 5)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _incrementarCantidad,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(40, 40),
                      ),
                      child: Text('+', style: TextStyle(fontSize: 30, color: Color.fromARGB(164, 225, 108, 5))),
                    ),
                  ],
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
