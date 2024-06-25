import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';

class HomeDomicilioScreen extends StatefulWidget {
  const HomeDomicilioScreen({super.key});

  @override
  State<HomeDomicilioScreen> createState() => _HomeDomicilioScreenState();
}

class _HomeDomicilioScreenState extends State<HomeDomicilioScreen> {
  final _scaffkey = GlobalKey<ScaffoldState>();
  final productosProvider = ProductosProvider();
  String email = "";
  double total = 0.0;
  List<int> quantities = List<int>.filled(5, 0);

  @override
  Widget build(BuildContext context) {
    final String? emailData = ModalRoute.of(context)?.settings.arguments as String?;
    if (emailData != null) {
      email = emailData;
    }

    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        title: const Text("Coffee Guillrmos", style: TextStyle(color: Colors.white)),
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
          _crearListado(),
        ],
      ),
      floatingActionButton: _floatingButton(context),
      //drawer: GetDrawer.getDrawer(context),
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
    return email == "admin@admin.com" ? _crearAdminItem(context, producto) : _crearUserItem(context, producto);
  }

  Widget _crearAdminItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        productosProvider.borrarProducto(producto.id!);
      },
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Column(
          children: [
            (producto.fotoUrl == null)
                ? const Image(image: AssetImage("images/assets/image.jpg"))
                : Container(
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
                  ),
            ListTile(
              title: Text("${producto.titulo} - \$${producto.valor.toStringAsFixed(2)}"),
              subtitle: Text("${producto.id}"),
              onTap: () async {
                Navigator.pushNamed(context, "/producto", arguments: producto);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearUserItem(BuildContext context, ProductoModel producto) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          (producto.fotoUrl == null)
              ? const Image(image: AssetImage("images/assets/image.jpg"))
              : Container(
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
                ),
          ListTile(
            title: Text("${producto.titulo} - \$${producto.valor.toStringAsFixed(2)}"),
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

  @override
  void initState() {
    super.initState();
    total = 0;
  }

  Widget _floatingButton(BuildContext context) {
    if (email == "admin@admin.com") {
      return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => Navigator.pushNamed(context, "/producto"),
      );
    } else {
      return FloatingActionButton(
        child: Icon(Icons.shopping_cart_sharp),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => Navigator.pushNamed(context, "/carrito"),
      );
    }
  }
}
