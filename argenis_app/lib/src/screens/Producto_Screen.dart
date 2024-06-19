import 'dart:io';

import 'package:argenis_app/src/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';
import 'package:argenis_app/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  const ProductoPage({super.key});

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final productoProvider = ProductosProvider();
  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  File? foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel? prodData = ModalRoute.of(context)?.settings.arguments as ProductoModel?;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Producto", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_size_select_actual, color: Colors.white,),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt,color: Colors.white,),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: "Producto"
      ),
      onSaved: (value) => producto.titulo = value!,
      validator: (value) {
        if (value!.length < 3) {
          return "Ingrese el nombre del producto";
        }
        return null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: "Precio"
      ),
      onSaved: (value) => producto.valor = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return "Sólo escriba números";
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: const Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      label: const Text("Guardar", style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    setState(() { _guardando = true; });

    if (foto != null) {
      producto.fotoUrl = await productoProvider.subirImagem(foto!);
    }

    if (producto.id == null) {
      await productoProvider.crearProducto(producto);
    } else {
      await productoProvider.EditarProducto(producto);
    }

    mostrarSnackbar("Registro Guardado");

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: const Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl!),
        placeholder: const AssetImage("images/assets/fondoPreview.gif"),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto!,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('images/pizzas/argeniss.jpg');
    }
  }

  void _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  void _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: origen);

    if (pickedFile != null) {
      foto = File(pickedFile.path);
      producto.fotoUrl = null;
      setState(() {});
    }
  }
}
