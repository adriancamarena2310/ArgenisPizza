import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String nameValue;
  late String phoneValue;
  late String emailValue;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  late FocusNode nameFocus;
  late FocusNode lastNameFocus;
  late FocusNode phoneFocus;
  late FocusNode emailFocus;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizzeria Argenis - Registro'),
      ),
      body: Container(
        decoration: BoxDecoration(
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
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Nombre:",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onSaved: (value) {
                    nameValue = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Llene este campo";
                    }
                    return null;
                  },
                  focusNode: nameFocus,
                  onEditingComplete: () => requestFocus(context, lastNameFocus),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Número de teléfono:",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    phoneValue = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Llene este campo";
                    }
                    return null;
                  },
                  focusNode: phoneFocus,
                  onEditingComplete: () => requestFocus(context, emailFocus),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico:",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    emailValue = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Llene este campo";
                    }
                    return null;
                  },
                  focusNode: emailFocus,
                  textInputAction: TextInputAction.done,
                ),
                ElevatedButton(
                  child: const Text('Registrar'),
                  onPressed: () {
                    _showHomeScreen(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _showHomeScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.of(context).pushNamed("/homeDomicilio", arguments: {
        'name': nameValue,
        'phone': phoneValue,
        'email': emailValue,
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    nameFocus.dispose();
    lastNameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    phoneFocus = FocusNode();
    emailFocus = FocusNode();
  }
}
