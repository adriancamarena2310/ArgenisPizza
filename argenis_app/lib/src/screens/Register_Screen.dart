import 'package:argenis_app/src/bloc/loggin_bloc.dart';
import 'package:argenis_app/src/bloc/provider.dart';
import 'package:argenis_app/src/providers/usuario_provider.dart';
import 'package:argenis_app/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController numberController;

  final usuarioProvider = UsuarioProvider();

  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;
  late FocusNode numberFocus;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de cuenta'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context); // Asegúrate de obtener el LoginBloc
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
            child: Column(
              children: [
                const Text("Crear cuenta", style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 60.0),
                _crearEmail(bloc!),
                const SizedBox(height: 30.0),
                _crearPassword(bloc),
                const SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          TextButton(   
           child: const Text("¿Ya tienes cuenta? Login"),
           onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
          ),
          const SizedBox(height: 100.0),
        ],
      ),
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
              hintText: "ejemplo@correo.com",
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
      stream: bloc.paswordStream,
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
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text("Ingresar", style: TextStyle(color: Colors.white),),
          ),
        );
      },
    );
  }

  void _register(LoginBloc bloc, BuildContext context) async {

    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if( info["ok"]){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/homeDomicilio");
    }else{
      // ignore: use_build_context_synchronously
      mostrarAlerta(context, info["mensaje"]);
    }
  }


  @override
  void initState() {
    super.initState();

    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    numberController = TextEditingController();

    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus = FocusNode();
    numberFocus = FocusNode();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    numberController.dispose();

    userNameFocus.dispose();
    passwordFocus.dispose();
    emailFocus.dispose();
    numberFocus.dispose();

    super.dispose();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
}
