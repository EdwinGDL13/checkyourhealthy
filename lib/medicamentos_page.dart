import 'package:flutter/material.dart';

// Modelo simple para medicamento
class Medicamento {
  String nombre;
  String dosis;
  List<String> horarios;

  Medicamento({
    required this.nombre,
    required this.dosis,
    required this.horarios,
  });
}

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  _MedicamentosPageState createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  List<Medicamento> medicamentos = [
    Medicamento(
      nombre: 'Paracetamol',
      dosis: '500 mg',
      horarios: ['08:00 AM', '08:00 PM'],
    ),
    Medicamento(
      nombre: 'Ibuprofeno',
      dosis: '200 mg',
      horarios: ['12:00 PM', '06:00 PM'],
    ),
    Medicamento(
      nombre: 'Amoxicilina',
      dosis: '250 mg',
      horarios: ['09:00 AM', '09:00 PM'],
    ),
  ];

  void _agregarMedicamento(Medicamento nuevoMedicamento) {
    setState(() {
      medicamentos.add(nuevoMedicamento);
    });
  }

  Future<void> _mostrarAgregarMedicamento() async {
    final nuevoMedicamento = await Navigator.push<Medicamento>(
      context,
      MaterialPageRoute(builder: (_) => const AgregarMedicamentoPage()),
    );

    if (nuevoMedicamento != null) {
      _agregarMedicamento(nuevoMedicamento);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Medicamentos',
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: medicamentos.isEmpty
            ? const Center(
                child: Text(
                  'No tienes medicamentos registrados.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: medicamentos.length,
                itemBuilder: (context, index) {
                  final medicamento = medicamentos[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: const Icon(
                        Icons.medication_liquid_outlined,
                        color: Colors.teal,
                        size: 32,
                      ),
                      title: Text(
                        medicamento.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Dosis: ${medicamento.dosis}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            children: medicamento.horarios
                                .map((h) => Chip(label: Text(h)))
                                .toList(),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Funcionalidad en desarrollo'),
                              backgroundColor: Colors.teal,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _mostrarAgregarMedicamento,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Agregar medicamento',
      ),
    );
  }
}

class AgregarMedicamentoPage extends StatefulWidget {
  const AgregarMedicamentoPage({super.key});

  @override
  _AgregarMedicamentoPageState createState() => _AgregarMedicamentoPageState();
}

class _AgregarMedicamentoPageState extends State<AgregarMedicamentoPage> {
  final _formKey = GlobalKey<FormState>();

  String nombre = '';
  String? dosisSeleccionada;
  final List<String> dosisOpciones = [
    '100 mg',
    '200 mg',
    '250 mg',
    '300 mg',
    '400 mg',
    '500 mg',
    '1000 mg',
  ];

  final List<String> horariosSeleccionados = [];

  Future<void> _seleccionarHorario() async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSeleccionada != null) {
      final formattedTime = horaSeleccionada.format(context);
      setState(() {
        if (!horariosSeleccionados.contains(formattedTime)) {
          horariosSeleccionados.add(formattedTime);
        }
      });
    }
  }

  void _eliminarHorario(String horario) {
    setState(() {
      horariosSeleccionados.remove(horario);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Medicamento'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre del medicamento',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingresa el nombre'
                      : null,
                  onSaved: (value) => nombre = value!.trim(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Dosis',
                    border: OutlineInputBorder(),
                  ),
                  value: dosisSeleccionada,
                  items: dosisOpciones
                      .map(
                        (dosis) =>
                            DropdownMenuItem(value: dosis, child: Text(dosis)),
                      )
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Selecciona una dosis' : null,
                  onChanged: (value) {
                    setState(() {
                      dosisSeleccionada = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Horarios seleccionados',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: horariosSeleccionados
                      .map(
                        (hora) => Chip(
                          label: Text(hora),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => _eliminarHorario(hora),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _seleccionarHorario,
                  icon: const Icon(Icons.access_time),
                  label: const Text('Agregar horario'),
                  style: TextButton.styleFrom(foregroundColor: Colors.teal),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (horariosSeleccionados.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Selecciona al menos un horario'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      _formKey.currentState!.save();

                      final nuevoMedicamento = Medicamento(
                        nombre: nombre,
                        dosis: dosisSeleccionada!,
                        horarios: horariosSeleccionados,
                      );

                      Navigator.pop(context, nuevoMedicamento);
                    }
                  },
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text(
                    'Guardar Medicamento',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
