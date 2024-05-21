import 'package:flutter/material.dart';

class GetDrawer extends StatelessWidget {
  const GetDrawer({Key? key}) : super(key: key);

  static Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("Ayala Camarena"),
            accountEmail: const Text("ayalacamarena@gmail.com"),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("images/assets/argenis.jpg")),
            otherAccountsPictures: const <Widget>[
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
        ],
      ),
    );
  }

  static void showHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Return an empty container or some default widget if needed
    return Container();
  }
}
