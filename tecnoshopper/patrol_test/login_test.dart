import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import 'login_robot.dart';

void main() {
  const testEmail = 'test@tecnoshopper.com';
  const testPassword = 'password123';

  patrolTest(
    'login exitoso con credenciales validas',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final robot = LoginRobot($);
      await robot.ingresarEmail(testEmail);
      await robot.ingresarPassword(testPassword);
      await robot.presionarBotonLogin();
      await robot.verificarInicioDeSesionExitoso();
    },
  );

  patrolTest(
    'login fallido con credenciales invalidas',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final robot = LoginRobot($);
      await robot.ingresarEmail('incorrecto@test.com');
      await robot.ingresarPassword('claveincorrecta');
      await robot.presionarBotonLogin();
      await robot.verificarMensajeDeError('Error de inicio de sesión');
    },
  );
}
