import 'package:argenis_app/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';


class PreviewScreen extends StatelessWidget {
  PreviewScreen({super.key});

  final usuarioProvider = UsuarioProvider();

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
                  _entrarHomeTienda(context);
                },
                child: const Text('Buscar en tienda'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: const Text('Entrega a domicilio'),
              ),
            ],
          ),
        ],
      ),
    );
  }


    void _entrarHomeTienda(BuildContext context) async {
    
    Map info = await usuarioProvider.login("test@test.com", "1234567");

    if( info["ok"]){
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/homeTienda");
    }

  }

}
