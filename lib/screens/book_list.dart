import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> products = [];
  List<dynamic> searchResults = [];

  String editedEstado = '';
  bool isPanelOpen = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
        Uri.parse('https://apilibros-iaeu.onrender.com/api/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar la lista de libros');
    }
  }

  void searchItems(String query) {
    setState(() {
      searchResults = products
          .where((product) =>
              product['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
final precioFormatter = NumberFormat.currency(symbol: '',locale: 'es_CO', );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Existencias'),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          labelText: 'Buscar Producto',
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
                        
                        for (final product in
                            searchResults.isNotEmpty ? searchResults : products)
                            
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Detalles Producto',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 100, 101, 1),
                                        )),
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                            Text(
                                              'Producto: ${product['nombre']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Cantidad: ${product['cantidad']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Precio: ${precioFormatter.format(product['precio'])}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                             Text(
                                              'Estado: ${product['estado']}',
                                              style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 100, 101, 1),
                                            )),
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            
                                            Text(
                                              ' ${product['nombre']}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                        '  ${precioFormatter.format(product['precio'])}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                          ],
                                        ),
                                         Column(
                                           children: [
                                             Text(
                                              ' ${product['cantidad']}',
                                              style: TextStyle(fontSize: 14),
                                        ),
                                ])
                                ]
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            maxHeight: 250,
            panel: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                Text("Productos bajos de stock", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                isPanelOpen
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final cantidad = product['cantidad'];
                            if (cantidad is int && cantidad < 6) { 
                          return ListTile(
                            title: Text(product['nombre'], style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                            subtitle: Text(cantidad.toString(), style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                          );
                        } else {
                          return SizedBox.shrink(); }
                          },
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            onPanelOpened: () {
              setState(() {
                isPanelOpen = true;
              });
            },
            onPanelClosed: () {
              setState(() {
                isPanelOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
