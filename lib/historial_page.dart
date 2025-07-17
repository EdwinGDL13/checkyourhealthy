import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí en el futuro puedes usar un ListView.builder con datos reales
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historial de Medicación',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Paracetamol 500mg'),
                  subtitle: Text('Tomado el 16 de julio, 8:00 AM'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Ibuprofeno 400mg'),
                  subtitle: Text('Tomado el 15 de julio, 2:00 PM'),
                ),
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.red),
                  title: Text('Omeprazol 20mg'),
                  subtitle: Text('No tomado el 14 de julio, 8:00 AM'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
