import 'dart:convert';

import 'package:consumir_api/screens/admin_screen.dart';
import 'package:consumir_api/screens/user_register_screen.dart';
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

  final String url= 'https://apilibros-iaeu.onrender.com/api/users/login';

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

        if(rol == 'Administrador'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminScreen()));
    
    
        }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Bienvenido'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ),
      ));

      }else if(response.statusCode == 401){
        final responseData = jsonDecode(response.body);
        final error = responseData['error'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('credenciales invalidas'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ),
      ));
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
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  hintText: 'Ingrese su correo',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  hintText: 'Ingrese su correo',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),)
                  
                ),
                obscureText: _isVisible,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                apiLogin();
              }, child: const Text('Iniciar Sesión')),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserRegisterScreen()));
              }, child: const Text('Registrarse'))

            ],
          )
        ),
      ),

    );
  }
}