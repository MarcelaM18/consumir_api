import 'package:flutter/material.dart';

class MenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showMenu;
  final bool centerTitle;

  const MenuAppbar({Key? key, this.showMenu = true, this.centerTitle = false})
      : super(key: key);

  @override
    Widget build(BuildContext context) {
    return AppBar(
      
      title: Center(
        child: Image.asset(
          'assets/img/logo.png',height: 100,),
      ),
      backgroundColor: Color.fromRGBO(0, 100, 101, 1),
      actions: showMenu
          ? [
              IconButton(
                onPressed: () {
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
                icon: const Icon(Icons.account_circle_outlined),
                color: Colors.white,
              ),
            ]
          : null,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size(0, kToolbarHeight);
}

