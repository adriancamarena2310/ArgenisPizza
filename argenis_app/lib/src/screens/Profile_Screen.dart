import 'package:Guillmors_coffe/src/models/usuario_model.dart';
import 'package:Guillmors_coffe/src/providers/productos_provider.dart';
import 'package:Guillmors_coffe/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  final UsuarioModel usuario;

  const EditProfileScreen({required this.usuario, Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioProvider = UsuarioProvider();
  final _usuarioProvider2 = ProductosProvider();
  UsuarioModel _usuario = UsuarioModel();

  File? _image;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_image != null) {
        _usuario.fotoUrl = await _usuarioProvider2.subirImagem(_image!);
      }
      await _usuarioProvider.EditarUsuario(_usuario);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UsuarioModel? usuario = ModalRoute.of(context)!.settings.arguments as UsuarioModel?;
    if (usuario != null) {
      _usuario = usuario;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 122, 64, 24),
      ),
      backgroundColor: Colors.white, 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _image != null ? FileImage(_image!) : _usuario.fotoUrl != null ? NetworkImage(_usuario.fotoUrl!) : const AssetImage('images/assets/default_avatar.png') as ImageProvider,
                  child: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _usuario.primerNombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _usuario.primerNombre = value!,
                validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _usuario.apellido,
                decoration: const InputDecoration(labelText: 'Apellido'),
                onSaved: (value) => _usuario.apellido = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Guardar Cambios', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 122, 64, 24), // Color marrón
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
