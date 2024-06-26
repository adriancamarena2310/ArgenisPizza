import 'package:flutter/material.dart';
import 'package:argenis_app/src/providers/usuario_provider.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Text(
              'Menú de navegación',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
            onTap: () {
              // Acción al presionar el botón de Favoritos
              Navigator.pushNamed(context, '/favoritos');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Acción al presionar el botón de Cerrar sesión
              _cerrarSesion(context);
            },
          ),
        ],
      ),
    );
  }

  void _cerrarSesion(BuildContext context) async {
    final usuarioProvider = UsuarioProvider();
    await usuarioProvider.cerrarSesion(); // Asegúrate de tener este método en tu UsuarioProvider
    Navigator.pushReplacementNamed(context, '/login');
  }
}
