import 'dart:io';

import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/providers/productos_provider.dart';
import 'package:argenis_app/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/bloc/loggin_bloc.dart';
import 'package:argenis_app/src/bloc/provider.dart';
import 'package:argenis_app/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController primerNombreController;
  late TextEditingController apellidoController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController numberController;

  
  final usuarioProvider = UsuarioProvider();
  File? foto;
  String? fotoUrl2; // URL de la foto seleccionada
  final productoProvider = ProductosProvider();

  late FocusNode primerNombreFocus;
  late FocusNode apellidoFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;
  late FocusNode numberFocus;

  UsuarioModel user = UsuarioModel(); 
  UsuarioModel usser = UsuarioModel(); 

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UsuarioModel usuario = ModalRoute.of(context)!.settings.arguments as UsuarioModel;
    if (usuario != null) {
      usser = usuario;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de cuenta', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 124, 74, 31),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_size_select_actual, color: Colors.white),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text("Crear cuenta", style: TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 60.0),
                  _mostrarFoto(),
                  const SizedBox(height: 30.0),
                  _crearPrimerNombre(bloc!),
                  //const SizedBox(height: 30.0),
                  _crearApellido(bloc),
                  const SizedBox(height: 30.0),
                  //_crearEmail(bloc),
                  //const SizedBox(height: 30.0),
                  //_crearPassword(bloc),
                  //const SizedBox(height: 30.0),
                  _crearBoton(bloc),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _crearPrimerNombre(LoginBloc bloc) {
  return StreamBuilder<String>(
    stream: bloc.primerNombreStream,
    builder: (context, snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: primerNombreController,
          decoration: InputDecoration(
            icon: const Icon(Icons.person, color: Colors.deepPurple),
            hintText: "",
            labelText: "Primer Nombre",
            counterText: snapshot.data,
            errorText: snapshot.error as String?,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese su primer nombre';
            }
            return null;
          },
          onChanged: bloc.changePrimerNombre,
          focusNode: primerNombreFocus,
          onEditingComplete: () => requestFocus(context, apellidoFocus),
        ),
      );
    },
  );
  }

  Widget _crearApellido(LoginBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.apellidoStream,
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: apellidoController,
            decoration: InputDecoration(
              icon: const Icon(Icons.person, color: Colors.deepPurple),
              hintText: "",
              labelText: "Apellido",
              counterText: snapshot.data,
              errorText: snapshot.error as String?,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su apellido';
              }
              return null;
            },
            onChanged: bloc.changeApellido,
            focusNode: apellidoFocus,
            onEditingComplete: () => requestFocus(context, emailFocus),
          ),
        );
      },
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: const Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: user.email,
              labelText: "Correo electrónico",
              counterText: snapshot.data,
              errorText: snapshot.error as String?,
            ),
            onChanged: bloc.changeEmail,
            focusNode: emailFocus,
            onEditingComplete: () => requestFocus(context, passwordFocus),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock_outline, color: Colors.deepPurple),
              labelText: "Contraseña",
              counterText: snapshot.data,
              errorText: snapshot.error as String?,
            ),
            onChanged: bloc.changePassword,
            focusNode: passwordFocus,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.formValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0.0,
            textStyle: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Validar formulario antes de proceder
            if (formKey.currentState?.validate() ?? false) {
              _register(bloc, context);
            } else {
              // Mostrar mensaje de validación no pasada si necesario
              print("Formulario no válido");
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text("Editar", style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  void _register(LoginBloc bloc, BuildContext context) async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      print("Formulario no válido");
      return;
    }
    // Obtener la URL de la foto, usando una cadena vacía si es null
    String fotoUrl = bloc.fotoUrl.isNotEmpty ? bloc.fotoUrl : '';

    var userEmail = await usuarioProvider.buscarUsuarioPorEmail(usser.email);

    if (foto != null) {
      fotoUrl2 = await productoProvider.subirImagem(foto!);
    }

    UsuarioModel user = UsuarioModel(
      primerNombre: bloc.primerNombre,
      apellido: bloc.apellido,
      email: userEmail!.email,
      password: userEmail.password,
      fotoUrl: fotoUrl2
    );

    var userCreado = await usuarioProvider.EditarUsuario(user);

      Navigator.pushReplacementNamed(context, "/homeDomicilio", arguments: user);
    
  }

  Widget _mostrarFoto() {
    final bloc = Provider.of(context);

    return StreamBuilder<String>(
      stream: bloc?.fotoUrlStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
          return FadeInImage(
            image: NetworkImage(snapshot.data!),
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
          // Placeholder image or default image when no fotoUrl or foto is available
          return Image.asset(
            'images/assets/image.jpg',
            fit: BoxFit.cover,
            height: 300.0,
          );
        }
      },
    );
  }

  void _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  void _procesarImagen(ImageSource origen) async {
  final bloc = Provider.of(context); // Obtener el bloc desde el Provider
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: origen);
  fotoUrl2 = pickedFile!.path;
  bloc?.changeFotoUrl(pickedFile!.path); 
  if (pickedFile != null) {
    setState(() {
      foto = File(pickedFile.path);
      // Actualizar el bloc con la URL de la imagen
    });
  }
}



  Future<String> _guardarImagenEnDirectorioTemporal(String fileName, File imagen) async {
    Directory directorioTemporal = await getTemporaryDirectory();
    String rutaTemporal = path.join(directorioTemporal.path, fileName);
    await imagen.copy(rutaTemporal);
    return rutaTemporal;
  }

  @override
  void initState() {
    super.initState();
    primerNombreController = TextEditingController();
    apellidoController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    numberController = TextEditingController();

    primerNombreFocus = FocusNode();
    apellidoFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus = FocusNode();
    numberFocus = FocusNode();
  }

  @override
  void dispose() {
    primerNombreController.dispose();
    apellidoController.dispose();
    passwordController.dispose();
    emailController.dispose();
    numberController.dispose();

    primerNombreFocus.dispose();
    apellidoFocus.dispose();
    passwordFocus.dispose();
    emailFocus.dispose();
    numberFocus.dispose();

    super.dispose();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
}
