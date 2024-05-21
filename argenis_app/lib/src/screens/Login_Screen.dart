import 'package:argenis_app/src/models/user_model.dart';
import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';
import 'package:flutter/material.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                focusNode: passwordFocus,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Llene este campo";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar Sesión'),
              ),
            ],
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

      bool existe = verificarUsuario(usuarios, userNameValue, passwordValue);
      if (existe) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeDomicilioScreen()),
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
