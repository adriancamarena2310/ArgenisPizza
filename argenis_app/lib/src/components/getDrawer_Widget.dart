import 'package:flutter/material.dart';
import 'package:argenis_app/src/models/user_model.dart';
import 'package:argenis_app/src/screens/Profile_Screen.dart';

class GetDrawer extends StatelessWidget {
  const GetDrawer({Key? key}) : super(key: key);

  static Widget getDrawer(BuildContext context, Usuario? user) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.userName ?? "Invitado",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            accountEmail: Text(user?.email ?? "invitado@example.com"),
            currentAccountPicture: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(user?.image ?? "images/assets/argenis.jpg"),
                ),
              ],
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(user)),
                  );
                },
              ),
            ],
            onDetailsPressed: () {},
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.black],
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
