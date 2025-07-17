import 'package:flutter_test/flutter_test.dart';
import 'package:control_medicacion_app/main.dart';

void main() {
  testWidgets(
    'Check initial screen shows RegisterPage and snack bar on register',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MedicApp());

      // Espera a que se construya la UI inicial
      await tester.pumpAndSettle();

      // Busca el botón de Registrarse (por texto)
      final registerButton = find.text('Registrarse');
      expect(registerButton, findsOneWidget);

      // Simula un tap sobre el botón de registro
      await tester.tap(registerButton);

      // Pumpea para procesar la animación y mostrar el SnackBar
      await tester.pump(); // inicia la animación
      await tester.pump(
        const Duration(milliseconds: 600),
      ); // espera el delay para que aparezca el SnackBar

      // Busca el texto "exitoso" que aparece en el SnackBar
      expect(find.textContaining('exitoso'), findsOneWidget);
    },
  );
}
