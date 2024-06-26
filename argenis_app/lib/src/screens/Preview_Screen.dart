import 'package:argenis_app/src/screens/Home_Tienda_Screen.dart';
import 'package:argenis_app/src/screens/Login_Screen.dart';
import 'package:flutter/material.dart';


class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/assets/fondoPreview.gif",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeTiendaScreen()),
                  );
                },
                child: const Text('Buscar en tienda'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Entrega a domicilio'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
