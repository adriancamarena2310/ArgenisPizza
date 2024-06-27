import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';
import 'package:argenis_app/src/screens/ver_producto.dart';
import 'package:argenis_app/src/screens/carrito_screen.dart' as carrito_screen;

class HomeTiendaScreem extends StatefulWidget {
  const HomeTiendaScreem({Key? key}) : super(key: key);

  @override
  _HomeTiendaScreemState createState() => _HomeTiendaScreemState();
}

class _HomeTiendaScreemState extends State<HomeTiendaScreem> {
  final _scaffkey = GlobalKey<ScaffoldState>();
  final productosProvider = ProductosProvider();

  List<int> quantities = [];
  List<ProductoModel> productos = [];

  @override
  void initState() {
    super.initState();
    _initializeQuantities();
  }

  void _initializeQuantities() async {
    final productosCargados = await productosProvider.cargarProductos();
    setState(() {
      productos = productosCargados;
      quantities = List<int>.filled(productos.length, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i], i),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto, int index) {
    int cantidad = quantities.isEmpty ? 0 : quantities[index];

    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/VerProducto", arguments: producto);
            },
            child: Stack(
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
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            if (cantidad > 0) {
                              setState(() {
                                quantities[index]--;
                              });
                            }
                          },
                        ),
                        Text(
                          "$cantidad",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (cantidad < 20) {
                              setState(() {
                                quantities[index]++;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("${producto.titulo} - \$${producto.valor.toStringAsFixed(2)}"),
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
    bool showCartButton = quantities.any((quantity) => quantity > 0);

    return showCartButton
        ? FloatingActionButton(
            child: Icon(Icons.shopping_cart_sharp),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => carrito_screen.CarritoScreen(
                  productos: productos,
                  quantities: quantities,
                ),
              ),
            ),
          )
        : Container();
  }
}
