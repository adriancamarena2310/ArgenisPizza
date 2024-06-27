import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/models/producto_model.dart';

class GetDrawer {
  final UsuarioModel user;
  final List<ProductoModel> productos;
  final List<int> quantities;

  GetDrawer({
    required this.user,
    required this.productos,
    required this.quantities,
  });
  

  Widget build(BuildContext context) {
    String name = "${user.primerNombre} ${user.apellido}";
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name ?? ''),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.fotoUrl != null
                  ? NetworkImage(user.fotoUrl!)
                  : AssetImage('images/assets/default_avatar.png') as ImageProvider,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 122, 64, 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/profile', arguments: user);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
              // Lógica para salir de la sesión
            },
          ),
        ],
      ),
    );
  }
}
