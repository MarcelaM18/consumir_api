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
            title: const Text('Productos'),
            onTap: () {
              // Coloca aquí la navegación a la página de productos
            },
          ),
          
          if (showMenu)
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Mostrar un diálogo de confirmación con el nombre del usuario
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Cerrar sesión'),
                      content: const Text('¿Estás seguro de que deseas cerrar la sesión?'),
                      actions: [
                          TextButton(
                            onPressed: () {
                              // Cerrar el diálogo y volver al inicio de sesión
                              Navigator.of(context).pop();
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            child: const Text('Sí'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Cerrar el diálogo
                              Navigator.of(context).pop();
                            },
                            child: const Text('No', style: TextStyle(
                            color: Colors.red),
                    ),
                          ),
                    ],
                    
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
