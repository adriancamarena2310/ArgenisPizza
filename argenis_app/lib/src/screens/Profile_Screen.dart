import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/user_model.dart';
import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';

class ProfileScreen extends StatefulWidget {
  final Usuario? user;
  const ProfileScreen(this.user, {Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController numberController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        color: Color.fromARGB(255, 249, 198, 45), // Fondo naranja
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: 'User Name'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Number'),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveChanges();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user?.userName);
    passwordController = TextEditingController(text: widget.user?.password);
    emailController = TextEditingController(text: widget.user?.email);
    numberController = TextEditingController(text: widget.user?.number);
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if(widget.user != null){
      setState(() {
        widget.user!.userName = userNameController.text;
        widget.user!.password = passwordController.text;
        widget.user!.email = emailController.text;
        widget.user!.number = numberController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cambios guardados con éxito"))
      );

      // Realiza la animación de transición
      Navigator.of(context).push(_createRoute());
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeDomicilioScreen(user: widget.user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
