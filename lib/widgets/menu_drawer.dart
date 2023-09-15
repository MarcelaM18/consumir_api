import 'package:flutter/material.dart';

class NavegationDrawer extends StatelessWidget {
  final bool showMenu;
  final bool centerTitle;

  const NavegationDrawer({Key? key, this.showMenu = true, this.centerTitle = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromRGBO(0, 100, 101, 1)),
            child: Center(
              child: Image.asset('assets/img/logo.png', height: 500),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              // Coloca aquí la navegación a la página de inicio
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Eventos'),
            onTap: () {
              // Coloca aquí la navegación a la página de productos
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Personas'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()),);
            },
          ),
        ],
      ),
    );
  }
}
