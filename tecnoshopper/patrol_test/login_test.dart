import 'package:patrol/patrol.dart';

import 'login_robot.dart';

void main() {
  patrolTest('Login Exitoso', ($) async {
    final loginRobot = LoginRobot($);

    await loginRobot.ingresarEmail('usuario@test.com');
    await loginRobot.presionarBotonLContinuar();
    await loginRobot.ingresarPassword('123456');
    await loginRobot.presionarBotonLContinuar();
    await loginRobot.verificarInicioDeSesionExitoso();
  });

  patrolTest('Login con credenciales inválidas', ($) async {
    final loginRobot = LoginRobot($);

    await loginRobot.ingresarEmail('usuario@test.com');
    await loginRobot.presionarBotonLContinuar();
    await loginRobot.ingresarPassword('incorrecto');
    await loginRobot.presionarBotonLContinuar();
    await loginRobot.verificarMensajeDeError('Credenciales inválidas');
  });
}
