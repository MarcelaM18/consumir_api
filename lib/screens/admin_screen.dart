import 'package:consumir_api/screens/admin_user_screen.dart';
import 'package:consumir_api/screens/books_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/menu_appbar.dart';
import '../widgets/menu_drawer.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Inicio',
      style: optionStyle,
    ),
   AdminUserScreen(),
    BooksScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavegationDrawer(),
      appBar:  MenuAppbar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Usuarios',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Libros',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(0, 100, 101, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}

