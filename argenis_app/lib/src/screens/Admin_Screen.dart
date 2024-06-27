import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/screens/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  UsuarioModel user = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    final UsuarioModel? usuario = ModalRoute.of(context)!.settings.arguments as UsuarioModel?;
    if (usuario != null) {
      user = usuario;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administración', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 124, 74, 31),
      ),
      backgroundColor: Colors.white, 
      body: _adminList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/producto");
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 124, 74, 31),
      ),
      drawer: GetDrawer(
        user: user,
        productos: [],
        quantities: [],
      ).build(context),
    );
  }

  Widget _adminList(BuildContext context) {
    final productosProvider = ProductosProvider(); // Aquí deberías usar tu propio provider

    return FutureBuilder(
      future: productosProvider.cargarProductos(), // Método para cargar productos, ajusta según tu provider
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data!;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return _crearAdminItem(context, producto);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearAdminItem(BuildContext context, ProductoModel producto) {
    final productosProvider = ProductosProvider(); // Aquí deberías usar tu propio provider

    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        productosProvider.borrarProducto(producto.id!); // Llama al método para eliminar el producto
      },
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Column(
          children: [
            // Imagen del producto
            (producto.fotoUrl == null)
                ? const Image(image: AssetImage("images/assets/image.jpg")) // Si no hay URL, muestra una imagen por defecto
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Borde gris
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        image: NetworkImage(producto.fotoUrl!), // Carga la imagen desde la URL
                        placeholder: const AssetImage("images/assets/fondoPreview.gif"), // Placeholder mientras carga la imagen
                        height: 300.0, // Altura de la imagen
                        width: double.infinity, // Ancho completo
                        fit: BoxFit.cover, // Ajuste de la imagen
                      ),
                    ),
                  ),
            // Información del producto en un ListTile
            ListTile(
              title: Text("${producto.titulo} - \$${producto.valor.toStringAsFixed(2)}"),
              subtitle: Text("${producto.id}"),
              onTap: () async {
                Navigator.pushNamed(context, "/producto", arguments: producto);
              },
            ),
          ],
        ),
      ),
    );
  }
}
