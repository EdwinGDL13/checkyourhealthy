// configuracion_page.dart
import 'package:flutter/material.dart';

class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Configuración',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Acción futura
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notificaciones'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Acción futura
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar sesión'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
