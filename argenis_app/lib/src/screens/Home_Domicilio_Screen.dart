import 'package:argenis_app/src/models/producto_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/components/getDrawer_Widget.dart';

class HomeDomicilioScreen extends StatefulWidget {
  const HomeDomicilioScreen({super.key});

  @override
  State<HomeDomicilioScreen> createState() => _HomeDomicilioScreenState();
}

class _HomeDomicilioScreenState extends State<HomeDomicilioScreen> {

  final _scaffkey = GlobalKey<ScaffoldState>();
   final productosProvider = ProductosProvider();

  double total = 0.0;
  List<int> quantities = List<int>.filled(5, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        title: const Text("Argenis"),
        backgroundColor: Colors.deepOrange,
      ),
      body: _crearListado(),
      //drawer: GetDrawer.getDrawer(context),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos(), 
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if( snapshot.hasData ){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos?.length,
            itemBuilder: (context, i) => _crearItem(context, productos![i]),
          );
        }else{
          return const Center( child:  CircularProgressIndicator());
        }
      }
      );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction){
        productosProvider.borrarProducto(producto.id!);
      },
      child: Card(
        child: Column(
          children: [
            (producto.fotoUrl == null) 
            ? const Image(image: AssetImage("images/pizzas/argeniss.jpg"))
            : FadeInImage(
              image: NetworkImage( producto.fotoUrl!),
              placeholder: const AssetImage("images/assets/fondoPreview.gif"),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
             ListTile(
        title: Text("${producto.titulo}  -  ${producto.valor}"),
        subtitle: Text("${producto.id}"),
        onTap: () async {
          Navigator.pushNamed(context, "/producto", arguments: producto);
          setState(() {});
        },
      ),
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    total = 0;
  }
}

/*
Container(
            color: Colors.deepOrange[500],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){},//_calcularTotal,
                  child: const Text("Calcular Total"),
                ),
                Text(
                  "Total: \$${total.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
 */