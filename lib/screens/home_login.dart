import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _isVisible = true;

  final String url= 'https://tmp-live-wr-group.trycloudflare.com/api/users/login';

  void apiLogin() async{
    final email = emailController.text;
    final password = passwordController.text;

    final body = jsonEncode({
      'correo' : email,
      'contrasena' : password
    });
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: body
      );

      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        final rol = responseData['rol'];
        final message = responseData['message'];
        final nombre = responseData['nombre'];

        if(rol == 'Adminitrador'){
          // Navegar a la pantala dashbord
        }else{
          //Navegar a la pantalla inicial del cliente
        }

      }
      else if(response.statusCode == 401){
        final responseData = jsonDecode(response.body);
        final error = responseData['error'];
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  hintText: 'Ingrese su correo',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  hintText: 'Ingrese su correo',
                  prefixIcon: const Icon(Icons.lock_clock),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),)
                  
                ),
                obscureText: _isVisible,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                apiLogin();
              }, child: Text('Iniciar Sesión'))
            ],
          )
        ),
      ),

    );
  }
}