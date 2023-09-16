import 'dart:convert';

import 'package:consumir_api/screens/admin_screen.dart';
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

        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 100, 101),
          content: const Text('Bienvenido'),
          duration: const Duration(seconds: 1),
          action: SnackBarAction(
            label: 'Cosmetic',
            textColor: Color.fromRGBO(234, 191, 63, 1),
            onPressed: () {},
          ),
        ),
      );
      }else if(response.statusCode == 401){
        final responseData = jsonDecode(response.body);
        final error = responseData['error'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 197, 8, 8),
        content: const Text('credenciales invalidas'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Error',
          textColor: Color.fromRGBO(255, 255, 255, 1),
          onPressed: () { },
        ),
      ));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                  height: 100,
                ),
              SizedBox(
                  width: 300,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      'assets/img/cosmetic.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              SizedBox(
                  width: 325.0,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Correo electrónico",
                      hintText: "Ingrese el correo",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite el correo';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 325.0,
                child: TextFormField(
                    controller: passwordController,
                    obscureText: _isVisible,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      hintText: "Ingrese la contraseña",
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite la contraseña';
                      }
                      return null;
                    },
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
              onPressed: () {
                apiLogin();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 100, 101, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Container(
                width: 150.0,
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Color.fromRGBO(234, 191, 63, 1),
                    ),
                  ),
                ),
              ),
            )

            ],
          )
        ),
      ),

    );
  }
}

