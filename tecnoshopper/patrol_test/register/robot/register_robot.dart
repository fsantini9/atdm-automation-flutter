import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

class RegisterRobot {
  final PatrolIntegrationTester $;

  RegisterRobot(this.$);

  Future<void> abrirPantallaRegistro() async {
    await $('¿Necesitás registrarte?').tap();
  }

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('register_email_field')).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(const ValueKey('register_password_field')).enterText(password);
  }

  Future<void> presionarBotonRegistrarse() async {
    await $(const ValueKey('register_button')).tap();
  }

  Future<void> completarRegistro(String email, String password) async {
    await ingresarEmail(email);
    await ingresarPassword(password);
    await presionarBotonRegistrarse();
  }

  Future<void> registrar(String email, String password) async {
    await abrirPantallaRegistro();
    await completarRegistro(email, password);
  }

  Future<void> verificarRegistroExitoso() async {
    await $('Registro exitoso').waitUntilVisible();
  }

  Future<void> aceptarRegistroExitoso() async {
    await $('OK').tap();
  }

  Future<void> verificarMensajeError(String mensaje) async {
    await $(mensaje).waitUntilVisible();
  }
}