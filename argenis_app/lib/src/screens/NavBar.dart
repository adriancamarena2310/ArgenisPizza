import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/usuario_model.dart';
import 'package:argenis_app/src/screens/Profile_Screen.dart';

class GetDrawer extends StatelessWidget {
  final UsuarioModel user;

  const GetDrawer({required this.user, Key? key}) : super(key: key);

  Widget getDrawer(BuildContext context) {
    final String name = "${user.primerNombre} ${user.apellido ?? ''}";

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            accountEmail: Text(user.email ?? "invitado@example.com"),
            currentAccountPicture: Container(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: user.fotoUrl != null
                    ? Image.network(
                        user.fotoUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "images/users/chikil.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, "/profile", arguments: user);
                },
              ),
            ],
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 133, 65, 20), Color.fromARGB(218, 0, 0, 0)],
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListTile(
            title: const Text("Inicio"),
            leading: const Icon(Icons.home),
            onTap: () => showHome(context),
          ),
          ListTile(
            title: const Text("Favoritos"),
            leading: const Icon(Icons.star_purple500_sharp),
            onTap: () => showHome(context),
          ),
          ListTile(
            title: const Text("Carrito"),
            leading: const Icon(Icons.shopping_cart_checkout_sharp),
            onTap: () => showHome(context),
          ),
          ListTile(
            title: const Text("Cerrar Sesión"),
            leading: const Icon(Icons.logout),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  static void showHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void logout(BuildContext context) {
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
