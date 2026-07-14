import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../login/robot/login_robot.dart';
import '../../mcp/mcp_client.dart';
import '../robot/perfil_robot.dart';

void main() {
  group('Suite Perfil', () {
  patrolTest(
    'configurar y guardar información personal',
    tags: ['smoke', 'regression'],
    ($) async {
      final user = await McpClient.getTestUser();

      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final perfilRobot = PerfilRobot($);

      // Login
      await loginRobot.ingresarEmail(user.email);
      await loginRobot.ingresarPassword(user.password);
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarInicioDeSesionExitoso();

      // Abrir perfil
      await perfilRobot.abrirPerfil();

      // Completar datos
      await perfilRobot.ingresarNombre('Jorge');
      await perfilRobot.ingresarApellido('Duarte');
      await perfilRobot.ingresarTelefono('099123456');
      await perfilRobot.ingresarFechaNacimiento('01/01/2000');
      await perfilRobot.ingresarDireccion('18 de julio 2030');
      await perfilRobot.ingresarPais('Uruguay');

      // Guardar
      await perfilRobot.guardar();

      // Validar
      await perfilRobot.verificarPerfilActualizado();
    },
  );

//EL SIGUIENTE TEST VA A FALLAR PORQUE EL SISTEMA TIENE UN BUG Y NO CONTROLA LOS CAMPOS VACÍOS:
  patrolTest(
    'configurar información personal con campos vacíos',
    tags: ['regression'],
    ($) async {
      final user = await McpClient.getTestUser();

      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final perfilRobot = PerfilRobot($);

      // Login
      await loginRobot.ingresarEmail(user.email);
      await loginRobot.ingresarPassword(user.password);
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarInicioDeSesionExitoso();

      // Abrir perfil
      await perfilRobot.abrirPerfil();

      // No completar ningún campo

      // Guardar
      await perfilRobot.guardar();

      // El sistema NO debería permitir guardar con campos vacíos.
      await perfilRobot.verificarQueNoSeActualizoElPerfil();
    },
  );
  });
}
