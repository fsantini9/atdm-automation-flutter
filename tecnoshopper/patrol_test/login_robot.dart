import 'package:patrol/patrol.dart';

class LoginRobot {
  final PatrolIntegrationTester $;

  LoginRobot(this.$);

  Future<void> ingresarEmail(String email) async {
    await $('email123_field').enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $('password_field').enterText(password);
  }

  Future<void> presionarBotonLContinuar() async {
    await $('continue_button').tap();
  }

  Future<void> verificarInicioDeSesionExitoso() async {
    await $('perfil_screen').waitUntilVisible();
  }

  Future<void> verificarMensajeDeError(String mensaje) async {
    await $(mensaje).waitUntilVisible();
  }
}
