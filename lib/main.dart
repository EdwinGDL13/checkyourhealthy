import 'package:flutter/material.dart';

import 'register_page.dart';
import 'login_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart'; // <-- Asegúrate de que este archivo exista

void main() {
  runApp(const MedicApp()); // Usa const para mejor performance
}

class MedicApp extends StatelessWidget {
  // Constructor recomendado con key y const
  const MedicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Medicación',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => MedicHomePage(), // <-- Ruta agregada
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
