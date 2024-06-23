import 'package:flutter/material.dart';
import 'package:argenis_app/src/screens/Home_Domicilio_Screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController numberController;

  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;
  late FocusNode numberFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color.fromARGB(255, 125, 60, 16),
      ),
      body: Container(
        
        color: const Color.fromARGB(255, 252, 251, 249), // Fondo naranja
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Container(
                color: const Color.fromARGB(255, 248, 249, 248),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: 'User Name',border: OutlineInputBorder(),),
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
                color: const Color.fromARGB(255, 248, 249, 248),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password',border: OutlineInputBorder(),),
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
                color: const Color.fromARGB(255, 248, 249, 248),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email',border: OutlineInputBorder(),),
                  focusNode: emailFocus,
                      onEditingComplete: () => requestFocus(context, numberFocus),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
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
                color: const Color.fromARGB(255, 248, 249, 248),
                child: TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(labelText: 'Number',border: OutlineInputBorder(),),
                  focusNode: numberFocus,
                  keyboardType: TextInputType.number,
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
                  _saveChanges();
                },
                child: const Text('Guardar'),
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
    //userNameController = TextEditingController(text: widget.user?.userName);
    //passwordController = TextEditingController(text: widget.user?.password);
    //emailController = TextEditingController(text: widget.user?.email);
    //numberController = TextEditingController(text: widget.user?.number);

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

  void _saveChanges() {
    /*
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
    }*/
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeDomicilioScreen(),
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
