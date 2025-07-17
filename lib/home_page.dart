import 'package:flutter/material.dart';
import 'medicamentos_page.dart';
import 'historial_page.dart';
import 'configuracion_page.dart';

class MedicHomePage extends StatefulWidget {
  @override
  _MedicHomePageState createState() => _MedicHomePageState();
}

class _MedicHomePageState extends State<MedicHomePage> {
  int currentIndex = 0;

  // Medicinas con solo la hora para dosis diaria
  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Paracetamol 500mg',
      'nextDose': const TimeOfDay(hour: 8, minute: 0),
      'taken': false,
    },
    {
      'name': 'Ibuprofeno 400mg',
      'nextDose': const TimeOfDay(hour: 14, minute: 0),
      'taken': false,
    },
    {
      'name': 'Vitamina C 1000mg',
      'nextDose': const TimeOfDay(hour: 20, minute: 0),
      'taken': false,
    },
  ];

  // Para detectar cambio de día y reiniciar estado
  DateTime _lastDateChecked = DateTime.now();

  @override
  void initState() {
    super.initState();
    _lastDateChecked = DateTime.now();
  }

  void _resetTakenIfNewDay() {
    final now = DateTime.now();
    if (!_isSameDate(now, _lastDateChecked)) {
      resetTaken(showSnackBar: false);
      _lastDateChecked = now;
    }
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void toggleMedicineTaken(int index) {
    setState(() {
      medicines[index]['taken'] = !medicines[index]['taken'];
    });

    final isTaken = medicines[index]['taken'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isTaken
              ? '${medicines[index]['name']} marcado como tomado.'
              : '${medicines[index]['name']} desmarcado.',
        ),
        backgroundColor: isTaken ? Colors.teal : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void resetTaken({bool showSnackBar = true}) {
    setState(() {
      for (var med in medicines) {
        med['taken'] = false;
      }
    });
    if (showSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Estado reiniciado.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool get allTaken => medicines.every((med) => med['taken'] == true);

  Widget getCurrentPage() {
    switch (currentIndex) {
      case 0:
        return buildInicioPage();
      case 1:
        return const MedicamentosPage();
      case 2:
        return const HistorialPage();
      case 3:
        return const ConfiguracionPage();
      default:
        return const Center(child: Text('Página no encontrada'));
    }
  }

  Widget buildInicioPage() {
    _resetTakenIfNewDay(); // Verificar cambio de día cada vez que se construye la página

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            '👋 ¡Hola!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            allTaken
                ? '✅ Hoy ya tomaste todas tus medicinas. ¡Bien hecho!'
                : '🔔 Tienes medicinas pendientes por tomar.',
            style: TextStyle(
              fontSize: 20,
              color: allTaken ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: medicines.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final med = medicines[index];
                final TimeOfDay nextDoseTime = med['nextDose'] as TimeOfDay;

                final now = DateTime.now();
                final nextDoseDateTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  nextDoseTime.hour,
                  nextDoseTime.minute,
                );

                final formattedDate =
                    "${nextDoseDateTime.day.toString().padLeft(2, '0')}/"
                    "${nextDoseDateTime.month.toString().padLeft(2, '0')}/"
                    "${nextDoseDateTime.year}";
                final formattedTime = nextDoseTime.format(context);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.medication,
                              color: Colors.teal,
                              size: 40,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                med['name'],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: med['taken']
                                  ? 'Medicina tomada'
                                  : 'Medicina no tomada',
                              child: Icon(
                                med['taken']
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: Colors.teal,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Próxima toma:',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          '$formattedDate a las $formattedTime',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => toggleMedicineTaken(index),
                            icon: Icon(
                              med['taken'] ? Icons.undo : Icons.check,
                              color: Colors.white,
                            ),
                            label: Text(
                              med['taken']
                                  ? 'Desmarcar como tomado'
                                  : 'Marcar como tomado',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: med['taken']
                                  ? Colors.orange
                                  : Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: allTaken ? resetTaken : null,
            icon: const Icon(Icons.restart_alt, color: Colors.white),
            label: const Text(
              'Reiniciar estado',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Medicación'),
        backgroundColor: Colors.teal,
      ),
      body: getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Medicamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ],
      ),
    );
  }
}
