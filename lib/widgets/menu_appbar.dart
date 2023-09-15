import 'package:consumir_api/main.dart';
import 'package:flutter/material.dart';

class MenuAppbar extends StatefulWidget implements PreferredSizeWidget {
  
  final bool showMenu;
  final bool centerTitle;

  const MenuAppbar({Key? key, this.showMenu = true, this.centerTitle = false})
      : super(key: key);
      
  @override
  State<MenuAppbar> createState() => _MenuAppbarState();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 100, 101, 1),
      title: Center(
        child: Image.asset('assets/img/logo.png', height: 100),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _MenuAppbarState extends State<MenuAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            final myapp = MyApp.of(context);
            if (myapp != null) {
              myapp.changeTheme();
            }
          },
          icon: Theme.of(context).brightness == Brightness.light
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
        )
      ],
    );
  }
}
