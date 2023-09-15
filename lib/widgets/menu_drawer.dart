import 'package:flutter/material.dart';

class NavegationDrawer extends StatelessWidget {
  const NavegationDrawer({Key? key});

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
            title: const Text('Home Page'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Home()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Eventos'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeEventos()),);
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
