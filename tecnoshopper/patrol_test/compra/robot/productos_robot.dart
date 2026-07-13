import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

class ProductosRobot {
  final PatrolIntegrationTester $;

  ProductosRobot(this.$);

  Future<void> seleccionarProducto(int indice) async {
    await $(Key('producto_card_$indice')).tap();
  }

  Future<void> agregarAlCarrito() async {
    await $(const ValueKey('add_to_cart_button')).tap();
  }

  Future<void> volverAlCatalogo() async {
    await $(const ValueKey('back_button')).tap();
  }

  Future<void> abrirCarrito() async {
    await $(const ValueKey('cart_button')).tap();
  }

  Future<void> presionarFinalizarCompra() async {
    await $(const ValueKey('checkout_button')).tap();
  }

  Future<void> verificarCarritoVisible() async {
    await $('Finalizar Compra').waitUntilVisible();
  }
}