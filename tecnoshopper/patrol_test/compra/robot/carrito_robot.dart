import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

class CarritoRobot {
  final PatrolIntegrationTester $;

  CarritoRobot(this.$);

  Future<void> presionarFinalizarCompra() async {
    await $(const ValueKey('checkout_button')).tap();
  }

  Future<void> verificarResumenPedidoVisible() async {
    await $('Resumen de Pedido').waitUntilVisible();
  }
}