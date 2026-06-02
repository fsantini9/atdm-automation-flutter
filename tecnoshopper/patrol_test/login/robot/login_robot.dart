import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class LoginRobot {
  final PatrolIntegrationTester $;

  LoginRobot(this.$);

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('email_field')).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(const ValueKey('password_field')).enterText(password);
  }

  Future<void> presionarBotonLogin() async {
    await $(const ValueKey('login_button')).tap();
  }

  Future<void> verificarInicioDeSesionExitoso() async {
    await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();
  }

  Future<void> verificarMensajeDeError(String mensaje) async {
    await $(mensaje).waitUntilVisible();
  }
}
