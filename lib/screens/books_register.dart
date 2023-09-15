import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BookRegister extends StatefulWidget {
  const BookRegister({super.key});

  @override
  State<BookRegister> createState() => _BookRegisterState();
}

class _BookRegisterState extends State<BookRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController anoController = TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 final String url= 'https://apilibros-iaeu.onrender.com/api/books';

 void apiBook() async{
  final name = nameController.text;
  final autor = autorController.text;
  final ano = int.parse(anoController.text);

  final body = jsonEncode({
    'nombre' : name,
    'autor' : autor,
    'ano' : ano
    
  });
  final response = await http.post(
    Uri.parse(url),
    headers:{
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: body

  );
  if(response.statusCode == 201){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro Exitoso'),
          ),
        );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error de Registro'),
          ),
        );
        }



 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ingrese el título',
                prefixIcon: Icon(Icons.book),
              ),  
            ),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                hintText: 'Ingrese el autor',
                prefixIcon: Icon(Icons.person),
              ),  
            ),
            TextField(
              controller: anoController,
              decoration: const InputDecoration(
                labelText: 'Año',
                hintText: 'Ingrese el año',
                prefixIcon: Icon(Icons.calendar_month),
              ),  
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
              apiBook();
              Navigator.pop(context);
            }, 
            child: const Text('Registrar'),
            ),
              ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, 
            child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
            ),

              ],
            )
            
          ],
        ))
      )
    );
  }
}