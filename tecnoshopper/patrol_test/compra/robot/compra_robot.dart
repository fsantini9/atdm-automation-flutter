import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

class CompraRobot {
  final PatrolIntegrationTester $;

  CompraRobot(this.$);

  // ==========================
  // Resumen del pedido
  // ==========================

  Future<void> finalizarCompra() async {
    await $(const ValueKey('checkout_button')).tap();
  }

  Future<void> siguiente() async {
    await $(const ValueKey('next_button')).tap();
  }

  // ==========================
  // Información
  // ==========================

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('email')).enterText(email);
  }

  Future<void> ingresarPais() async {
    // El formulario ya abre con Uruguay seleccionado,
    // por lo que no es necesario hacer nada.
  }

  Future<void> ingresarApellido(String apellido) async {
    await $(const ValueKey('apellido')).enterText(apellido);
  }

  Future<void> ingresarDireccion(String direccion) async {
    await $(const ValueKey('direccion')).enterText(direccion);
  }

  Future<void> ingresarCiudad(String ciudad) async {
    await $(const ValueKey('ciudad')).enterText(ciudad);
  }

  Future<void> ingresarCodigoPostal(String codigoPostal) async {
    await $(const ValueKey('postal')).enterText(codigoPostal);
  }

  Future<void> continuarAlPago() async {
    final boton = $(const ValueKey('continue_payment_button'));

    await boton.scrollTo();
    await boton.tap();
  }

  // ==========================
  // Pago
  // ==========================

  Future<void> ingresarNumeroTarjeta(String numero) async {
    await $(const ValueKey('ccNumero')).enterText(numero);
  }

  Future<void> ingresarNombreTarjeta(String nombre) async {
    await $(const ValueKey('ccNombre')).enterText(nombre);
  }

  Future<void> ingresarFechaExpiracion(String fecha) async {
    await $(const ValueKey('ccExpFecha')).enterText(fecha);
  }

  Future<void> ingresarCodigoSeguridad(String codigo) async {
    await $(const ValueKey('ccCodigo')).enterText(codigo);
  }

  Future<void> comprar() async {
    final boton = $(const ValueKey('buy_button'));

    await boton.scrollTo();
    await boton.tap();
  }

  // ==========================
  // Validaciones
  // ==========================

  Future<void> verificarCompraExitosa() async {
    await $('¡Tu pedido ha sido procesado con éxito!').waitUntilVisible();
  }

  Future<void> volver() async {
    await $(const ValueKey('back_form_button')).tap();
  }
}
