import 'package:argenis_app/src/models/user_model.dart';
import 'package:argenis_app/src/screens/Login_Screen.dart';
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

  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;
  late FocusNode numberFocus;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizzeria Argenis - Registro'),
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
                      labelText: 'Nombre de usuario',
                      border: InputBorder.none,
                    ),
                    focusNode: userNameFocus,
                    onEditingComplete: () =>
                        requestFocus(context, passwordFocus),
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
                    color: const Color.fromARGB(255, 248, 249, 248),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: InputBorder.none,
                    ),
                    focusNode: passwordFocus,
                    onEditingComplete: () => requestFocus(context, emailFocus),
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
                    color: const Color.fromARGB(255, 248, 249, 248),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      border: InputBorder.none,
                    ),
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => requestFocus(context, numberFocus),
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
                    color: const Color.fromARGB(255, 248, 249, 248),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      labelText: 'Número de teléfono',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    focusNode: numberFocus,
                    textInputAction: TextInputAction.next,
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
                  onPressed: () {
                    _newUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
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

  void _newUser() {
    Usuario? newUser = Usuario(
      id: ultimoUsuario()!.id + 1,
      userName: userNameController.text,
      password: passwordController.text,
      email: emailController.text,
      number: numberController.text,
      image: "images/assets/argenis.jpg",
    );
    
    usuarios.add(newUser);
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
