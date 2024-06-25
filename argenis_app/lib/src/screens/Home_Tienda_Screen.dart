import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/components/getDrawer_Widget.dart';
import 'package:argenis_app/src/screens/preview_screen.dart';
import 'package:argenis_app/src/screens/ver_producto.dart';  // Importa la nueva pantalla

class HomeTiendaScreem extends StatefulWidget {
  const HomeTiendaScreem({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeTiendaScreemState createState() => _HomeTiendaScreemState();
}

class _HomeTiendaScreemState extends State<HomeTiendaScreem> {
  final _scaffkey = GlobalKey<ScaffoldState>();
  final productosProvider = ProductosProvider();

  double total = 0.0;
  List<int> quantities = List<int>.filled(5, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        title: const Text("Coffee Guillrmos", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 122, 64, 24),
      ),
      body: _crearListado(),
      floatingActionButton: _floatingButton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos?.length,
            itemBuilder: (context, i) => _crearItem(context, productos![i]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/VerProducto", arguments: producto);
            },
            child: (producto.fotoUrl == null)
                ? const Image(image: AssetImage("images/users/chikil.jpg"))
                : FadeInImage(
                    image: NetworkImage(producto.fotoUrl!),
                    placeholder: const AssetImage("images/assets/fondoPreview.gif"),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          ListTile(
            title: Text("${producto.titulo} - ${producto.valor}"),
            subtitle: Text("${producto.id}"),
            onTap: () async {
              Navigator.pushNamed(context, "/VerProducto", arguments: producto);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _floatingButton(BuildContext context) {
      if(1 == 1){//debe salir carrito carrito 
      return FloatingActionButton(
        child: Icon(Icons.shopping_cart_sharp),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => Navigator.pushNamed(context, "/carrito"),
      );
      }else{// no debe salir carrito
        return Container(); 
    }
  }
}
