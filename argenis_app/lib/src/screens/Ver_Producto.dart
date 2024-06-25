import 'package:argenis_app/src/models/producto_model.dart';
import 'package:flutter/material.dart';

class VerProductoScreen extends StatefulWidget {
  const VerProductoScreen({super.key});

  @override
  State<VerProductoScreen> createState() => _VerProductoScreenState();
}

class _VerProductoScreenState extends State<VerProductoScreen> {

  ProductoModel producto = ProductoModel();


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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mostrarFoto(),
            SizedBox(height: 20),
            Text(
              producto.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Descripción: ${producto.descripcion ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Precio: \$${producto.valor.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

   Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl!),
        placeholder: const AssetImage("images/assets/fondoPreview.gif"),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset('images/users/chikil.jpg');
    }
  }
}