import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/user_model.dart';
import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';
import 'package:argenis_app/src/screens/Register_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  late FocusNode userNameFocus;
  late FocusNode passwordFocus;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: Color.fromARGB(230, 127, 63, 3),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/assets/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 249, 248),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      border: InputBorder.none,
                    ),
                    focusNode: userNameFocus,
                    onEditingComplete: () => requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene este campo";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 247, 244),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: InputBorder.none,
                    ),
                    focusNode: passwordFocus,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene este campo";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Iniciar Sesión'),
                ),
                const SizedBox(height: 8), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      String userNameValue = userNameController.text;
      String passwordValue = passwordController.text;

      var existe = verificarUsuario(usuarios, userNameValue, passwordValue);
      var user = obtenerUsuarioPorUserName(usuarios, userNameValue);
      if (existe) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeDomicilioScreen(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    userNameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
}
