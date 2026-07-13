import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../login/robot/login_robot.dart';
import '../../mcp/mcp_client.dart';
import '../robot/compra_robot.dart';
import '../robot/productos_robot.dart';

void main() {
  patrolTest(
    'compra exitosa',
    ($) async {
      final user = await McpClient.getTestUser();

      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final productosRobot = ProductosRobot($);
      final compraRobot = CompraRobot($);

      // Login
      await loginRobot.ingresarEmail(user.email);
      await loginRobot.ingresarPassword(user.password);
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarInicioDeSesionExitoso();

      // Producto
      await productosRobot.seleccionarProducto(1);
      await productosRobot.agregarAlCarrito();
      await productosRobot.volverAlCatalogo();
      await productosRobot.abrirCarrito();
      await productosRobot.verificarCarritoVisible();

      // Checkout
      await compraRobot.finalizarCompra();
      await compraRobot.siguiente();

      // Información
      await compraRobot.ingresarEmail('jorge@test.com');
      await compraRobot.ingresarPais();
      await compraRobot.ingresarApellido('Duarte');
      await compraRobot.ingresarDireccion('18 de julio 2030');
      await compraRobot.ingresarCiudad('Montevideo');
      await compraRobot.ingresarCodigoPostal('11000');
      await compraRobot.continuarAlPago();

      // Pago
      await compraRobot.ingresarNumeroTarjeta('4444444444444444');
      await compraRobot.ingresarNombreTarjeta('Jorge Duarte');
      await compraRobot.ingresarFechaExpiracion('1050');
      await compraRobot.ingresarCodigoSeguridad('111');

      await compraRobot.comprar();

      // Validación
      await compraRobot.verificarCompraExitosa();
    },
  );

   patrolTest(
    'compra cancelada',
    ($) async {
      final user = await McpClient.getTestUser();

      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final productosRobot = ProductosRobot($);
      final compraRobot = CompraRobot($);

      // Login
      await loginRobot.ingresarEmail(user.email);
      await loginRobot.ingresarPassword(user.password);
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarInicioDeSesionExitoso();

      // Producto
      await productosRobot.seleccionarProducto(1);
      await productosRobot.agregarAlCarrito();
      await productosRobot.volverAlCatalogo();

      // Carrito
      await productosRobot.abrirCarrito();
      await productosRobot.verificarCarritoVisible();

      // Resumen
      await compraRobot.finalizarCompra();
      await compraRobot.siguiente();

      // Información
      await compraRobot.ingresarEmail('jorge@test.com');
      await compraRobot.ingresarApellido('Duarte');
      await compraRobot.ingresarDireccion('18 de julio 2030');
      await compraRobot.ingresarCiudad('Montevideo');
      await compraRobot.ingresarCodigoPostal('11000');

      await compraRobot.continuarAlPago();

      // Pago
      await compraRobot.ingresarNumeroTarjeta('4444444444444444');
      await compraRobot.ingresarNombreTarjeta('Jorge Duarte');
      await compraRobot.ingresarFechaExpiracion('1050');
      await compraRobot.ingresarCodigoSeguridad('111');

      // Cancelar compra
      await compraRobot.volver(); // Pago -> Información
      await compraRobot.volver(); // Información -> Resumen
      await compraRobot.volver(); // Resumen -> Carrito

      // Validación
      await productosRobot.verificarCarritoVisible();
    },
  );
}