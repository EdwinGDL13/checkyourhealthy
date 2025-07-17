import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:control_medicacion_app/main.dart';

void main() {
  testWidgets('Check initial screen shows RegisterPage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MedicApp());

    // Verificamos que el texto o widget de la pantalla de registro está presente
    expect(
      find.text('exitoso'),
      findsOneWidget,
    ); // Cambia 'Registrar' por algún texto que esté en tu pantalla RegisterPage
  });
}
