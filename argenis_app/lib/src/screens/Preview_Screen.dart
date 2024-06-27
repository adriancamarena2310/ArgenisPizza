import 'package:Guillmors_coffe/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({super.key});

  final usuarioProvider = UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/assets/fondoPreview.gif",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Spacer(flex: 30), // Contenedor vacío que ocupa el 70% de la pantalla
              ElevatedButton.icon(
                onPressed: () {
                  _entrarHomeTienda(context);
                },
                icon: Icon(Icons.store, color: Colors.deepPurple,),
                label: const Text('Buscar en tienda',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                icon: Icon(Icons.delivery_dining,color: Colors.deepPurple,),
                label: const Text('Entrega a domicilio',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildLocationButton(), // Botón de ubicación
              Spacer(flex: 3), // Espacio restante (30% de la pantalla)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        const url = 'https://www.google.com.mx/maps/place/Trecaffè+-+Via+dei+due+Macelli/@41.9033548,12.4825267,17z/data=!3m1!4b1!4m6!3m5!1s0x132f61ab5cfaaed3:0xf4da7256fe11f8a!8m2!3d41.9033508!4d12.485107!16s%2Fg%2F11c54_5rm1?entry=ttu';
        if (!await launchUrl(Uri.parse(url))) {
          throw 'Could not launch $url';
        }
      },
      icon: Icon(Icons.location_on,color: Colors.deepPurple,),
      label: Text(
        'Nos ubicamos en',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _entrarHomeTienda(BuildContext context) async {
    Map info = await usuarioProvider.login("test@test.com", "1234567");

    if (info["ok"]) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/homeTienda");
    }
  }
}
