
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic>books = [];
  List<dynamic> searchResults = [];

String editedEstado = '';

  @override
  void initState() {
    super.initState();
    fetchBooks();
    
  }


 
   Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://apilibros-iaeu.onrender.com/api/books'));
    if (response.statusCode == 200) {
      setState(() {
        books = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar la lista de libros');
    }
  }


  void searchItems(String query) {
    setState(() {
      searchResults = books.where((book) =>
          book['nombre'].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Existencias'),
        ],
      ),  
      ),
      body: Center(
        child: Column(

          children: [
      
           Container(
          width: 500,
          height: 52,
          margin: const EdgeInsets.fromLTRB(18, 20, 18, 0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(207, 248, 248, 248),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                onChanged: searchItems,
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar Libro',
                  suffixIcon: Icon(Icons.search),
                  
                ),
              ),
            ),
          ),
        ),
                      SizedBox(height: 20),

                      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            for (final book in searchResults.isNotEmpty ? searchResults : books)
               GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Detalles Producto', style: TextStyle(color: Color.fromRGBO(0, 100, 101, 1))),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Nombre: ${book['nombre']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Autor: ${book['autor']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            // Agregar más detalles aquí según tus necesidades
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color:Color.fromRGBO(0, 100, 101, 1))),
                          ),
                        ],
                      );
                    },
                  );
                },
             child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                        Text(
                          '${book['nombre']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${book['autor']}',
                          style: TextStyle(fontSize: 16),
                        ),
                   
                   
                  ],
                ),
              ),
               ),
          ],
        ),
      ),
    ),
  
          ],
        ),




      )





    );
  }
}
