import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/producto_model.dart';

class CarritoScreen extends StatelessWidget {
  final List<ProductoModel> productos;
  final List<int> quantities;

  CarritoScreen({required this.productos, required this.quantities});

  @override
  Widget build(BuildContext context) {
    final productosEnCarrito = List.generate(productos.length, (index) {
      if (quantities[index] > 0) {
        return productos[index];
      }
      return null;
    }).where((producto) => producto != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
        backgroundColor: Color.fromARGB(255, 122, 64, 24),
      ),
      body: productosEnCarrito.isEmpty
          ? Center(
              child: Text("No hay productos en el carrito"),
            )
          : ListView.builder(
              itemCount: productosEnCarrito.length,
              itemBuilder: (context, index) {
                final producto = productosEnCarrito[index]!;
                return ListTile(
                  title: Text("${producto.titulo} - \$${producto.valor.toStringAsFixed(2)}"),
                  subtitle: Text("Cantidad: ${quantities[productos.indexOf(producto)]}"),
                  leading: producto.fotoUrl == null
                      ? Image(image: AssetImage("images/assets/image.jpg"))
                      : Image.network(producto.fotoUrl!),
                );
              },
            ),
    );
  }
}
