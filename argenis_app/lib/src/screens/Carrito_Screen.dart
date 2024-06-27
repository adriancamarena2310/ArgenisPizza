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

    // Calcular el total de la compra
    double totalCompra = 0;
    for (int i = 0; i < productosEnCarrito.length; i++) {
      totalCompra += productosEnCarrito[i]!.valor * quantities[productos.indexOf(productosEnCarrito[i]!)];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito",style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 122, 64, 24),
      ),
      backgroundColor: Colors.white, 
      body: productosEnCarrito.isEmpty
          ? Center(
              child: Text("No hay productos en el carrito"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Mostrar alerta con el total de la compra
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Pedido hecho"),
                          content: Text("Total a pagar: \$${totalCompra.toStringAsFixed(2)}"),
                          backgroundColor: Colors.white, 
                          actions: [
                            TextButton(
                              child: Text("Aceptar"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Cerrar la alerta
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 122, 64, 24)), // Color café
                    ),
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white), // Texto blanco
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
