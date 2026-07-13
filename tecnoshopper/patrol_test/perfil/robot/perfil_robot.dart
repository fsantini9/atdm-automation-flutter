import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';

class PerfilRobot {
  final PatrolIntegrationTester $;

  PerfilRobot(this.$);

  // Abrir pantalla de perfil
  Future<void> abrirPerfil() async {
    await $(const ValueKey('profile_button')).tap();
  }

  Future<void> ingresarNombre(String nombre) async {
    await $(const ValueKey('nombre_field')).enterText(nombre);
  }

  Future<void> ingresarApellido(String apellido) async {
    await $(const ValueKey('apellido_field')).enterText(apellido);
  }

  Future<void> ingresarTelefono(String telefono) async {
    await $(const ValueKey('telefono_field')).enterText(telefono);
  }

  Future<void> ingresarFechaNacimiento(String fecha) async {
    await $(const ValueKey('fecha_nacimiento_field')).enterText(fecha);
  }

  Future<void> ingresarDireccion(String direccion) async {
    await $(const ValueKey('direccion_field')).enterText(direccion);
  }

  Future<void> ingresarPais(String pais) async {
    await $(const ValueKey('pais_field')).enterText(pais);
  }

  Future<void> guardar() async {
    await $(const ValueKey('guardar_perfil_button')).tap();
  }

  Future<void> verificarPerfilActualizado() async {
    await $('Perfil actualizado correctamente').waitUntilVisible();
  }

  Future<void> verificarErrorActualizacion() async {
    await $('Error al actualizar el perfil').waitUntilVisible();
  }

  Future<void> verificarQueNoSeActualizoElPerfil() async {
    expect(
      $('Perfil actualizado correctamente').exists,
      isFalse,
      reason:
          'El perfil no debería guardarse cuando existen campos obligatorios vacíos.',
    );
  }
}
