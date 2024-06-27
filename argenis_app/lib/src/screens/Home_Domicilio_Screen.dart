import 'package:Guillmors_coffe/src/models/producto_model.dart';
import 'package:Guillmors_coffe/src/models/usuario_model.dart';
import 'package:Guillmors_coffe/src/providers/productos_provider.dart';
import 'package:Guillmors_coffe/src/screens/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'carrito_screen.dart' as carrito_screen;

class HomeDomicilioScreen extends StatefulWidget {
  const HomeDomicilioScreen({Key? key}) : super(key: key);

  @override
  State<HomeDomicilioScreen> createState() => _HomeDomicilioScreenState();
}

class _HomeDomicilioScreenState extends State<HomeDomicilioScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final productosProvider = ProductosProvider();
  UsuarioModel user = UsuarioModel();
  List<int> quantities = [];
  List<ProductoModel> productos = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeQuantities();
    _initSharedPreferences();
  }

  void _initializeQuantities() async {
    final productosCargados = await productosProvider.cargarProductos();
    setState(() {
      productos = productosCargados;
      quantities = List<int>.filled(productosCargados.length, 0);
    });
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _toggleFavorito(ProductoModel producto) {
    setState(() {
      bool isFavorito = _prefs.getBool('favorito_${producto.id}') ?? false;
      isFavorito = !isFavorito;
      _prefs.setBool('favorito_${producto.id}', isFavorito);

    });
  }

  void _eliminarProducto(ProductoModel producto) {
    setState(() {
      productos.removeWhere((prod) => prod.id == producto.id);
      // También podrías llamar a productosProvider para eliminar el producto de la base de datos si es necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    final UsuarioModel? usuario = ModalRoute.of(context)!.settings.arguments as UsuarioModel?;
    if (usuario != null) {
      user = usuario;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Coffee Guillrmos", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 122, 64, 24),
      ),
      backgroundColor: Colors.white, 
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
      drawer: GetDrawer(
        user: user,
        productos: productos,
        quantities: quantities,
      ).build(context,), // Llama al método build() para obtener el drawer
    );
  }

  Widget _crearListado() {
    return FutureBuilder<List<ProductoModel>>(
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
    // Verifica que quantities no esté vacío y que index esté dentro del rango válido
    if (quantities.isNotEmpty && index < quantities.length) {
      int cantidad = quantities[index];
      bool isFavorito = _prefs.getBool('favorito_${producto.id}') ?? false;

      return user.email == "admin@admin.com"
          ? _crearAdminItem(context, producto)
          : _crearUserItem(context, producto, cantidad, isFavorito, index);
    } else {
      return Container(); // Otra acción en caso de que quantities esté vacío
    }
  }

  Widget _crearAdminItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        _eliminarProducto(producto);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/VerProducto", arguments: producto);
        },
        child: Card(
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              Stack(
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
                ],
              ),
              ListTile(
                title: Text("${producto.titulo}"),
                subtitle: Text("\$${producto.valor.toStringAsFixed(2)}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearUserItem(BuildContext context, ProductoModel producto, int cantidad, bool isFavorito, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/VerProducto", arguments: producto);
      },
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Column(
          children: [
            Stack(
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
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
                          icon: const Icon(Icons.add, color: Colors.white),
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
            ListTile(
              title: Text("${producto.titulo}"),
              subtitle: Text("\$${producto.valor.toStringAsFixed(2)}"),
            ),
            IconButton(
              iconSize: 30, // Aumenta el tamaño del icono
              icon: Icon(
                isFavorito ? Icons.star : Icons.star_border,
                color: isFavorito ? Colors.yellow : Colors.grey,
              ),
              onPressed: () {
                _toggleFavorito(producto);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingButton(BuildContext context) {
    bool showCartButton = quantities.any((quantity) => quantity > 0);

    if (user.email == "admin@admin.com") {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/SubirProducto").then((value) {
            // Actualizar la lista de productos después de subir uno nuevo si es necesario
            _initializeQuantities();
          });
        },
      );
    } else {
      return showCartButton
          ? FloatingActionButton(
              child: const Icon(Icons.shopping_cart),
              backgroundColor: Color.fromARGB(255, 124, 74, 31),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => carrito_screen.CarritoScreen(
                      productos: productos,
                      quantities: quantities,
                    ),
                  ),
                );
              },
            )
          : Container(); // Devuelve un contenedor vacío si no hay productos en el carrito
    }
  }
}
