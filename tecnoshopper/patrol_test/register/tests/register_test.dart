import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../robot/register_robot.dart';

void main() {
  group('Suite Registro', () {
  patrolTest(
    'registro exitoso con datos válidos',
    tags: ['smoke', 'regression'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final robot = RegisterRobot($);

      await robot.registrar(
        'prueba@gmail.com',
        '12345',
      );

      await robot.verificarRegistroExitoso();
    },
  );


  patrolTest(
    'registro inválido con email ya registrado',
    tags: ['regression'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final robot = RegisterRobot($);

      // 1) Crear usuario válido
      await robot.registrar(
        'usuario_prueba@gmail.com',
        '12345',
      );

      await robot.verificarRegistroExitoso();

      // 2) Cerrar mensaje y volver al login
      await robot.aceptarRegistroExitoso();

      // 3) Ir nuevamente a registro
      await robot.abrirPantallaRegistro();

      // 4) Intentar registrar el mismo usuario
      await robot.completarRegistro(
        'usuario_prueba@gmail.com',
        '12345',
      );

      // 5) Validar error
      await robot.verificarMensajeError(
        'El correo electrónico ya está registrado.',
      );
    },
  );
  });
}