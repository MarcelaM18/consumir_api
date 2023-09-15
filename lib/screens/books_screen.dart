import 'package:consumir_api/screens/books_register.dart';
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
  List<dynamic> filteredBooks = [];

String editedEstado = '';

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }


  Future<void> editbook(Map<String, dynamic> bookData) async {
    Map<String, dynamic> editedData = {...bookData};
    editedEstado = bookData['estado'];

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Usuario'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) {
                    editedData['nombre'] = value;
                  },
                  controller: TextEditingController(text: bookData['nombre']),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'autor'),
                  onChanged: (value) {
                    editedData['autor'] = value;
                  },
                  controller: TextEditingController(text: bookData['autor']),
                ),
                 TextField(
                  decoration: const InputDecoration(labelText: 'ano'),
                  onChanged: (value) {
                    editedData['ano'] = value;
                  },
                  controller: TextEditingController(text: bookData['ano']),
                ),
                DropdownButton<String>(
                  value: editedEstado.isNotEmpty
                      ? editedEstado
                      : bookData['estado'],
                  items: <String>['Activo', 'Inactivo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      editedEstado = newValue!;
                    });
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final response = await http.put(
                  Uri.parse(
                      'https://apilibros-iaeu.onrender.com/api/books/${bookData['_id']}'),
 
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'nombre': editedData['nombre'],
                    'autor': editedData['autor'],
                    'estado': editedEstado,
                  }),
                );

                if (response.statusCode == 200) {
                  fetchBooks();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                } else {
                  // Manejar errores de actualización
                  throw Exception('Error al actualizar el usuario');
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
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

  Future<void> deletebook(String bookId) async {
    final response = await http.delete(
      Uri.parse(
          'https://apilibros-iaeu.onrender.com/api/books/$bookId'),
    );
    if (response.statusCode == 204) {
      fetchBooks();
    } else {
      throw Exception('Error al eliminar el usuario');
    }
}

void searchItems(String query) {
  setState(() {
    filteredBooks = books
        .where((book) =>
            book['nombre']
                .toLowerCase()
                .contains(query.toLowerCase())) // Puedes personalizar tu lógica de búsqueda aquí
        .toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Libros'),  
      ),
      body: Center(
        child: Column(

          children: [
      
            Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookRegister(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.book,
                            size: 50,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      const Text('Registrar'),
                      SizedBox(height: 20,),
                           Container(
          width: 317,
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

                      Expanded(
                        child:
                        ListView.builder(
                      itemCount: filteredBooks.isNotEmpty
                          ? filteredBooks.length
                          : books.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks.isNotEmpty
                            ? filteredBooks[index]
                            : books[index];
                        return ListTile(
          title: Text(book['nombre']),
          subtitle: Text(book['autor']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  editbook(book);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Eliminar Libro'),
                        content: const Text(
                            '¿Seguro que deseas eliminar este libro?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              deletebook(book['_id']);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Eliminar'),
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
                      },
                    )

                      ),

                      
            
          ],
        ),




      )





    );
  }
}
