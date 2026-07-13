import 'dart:convert';

import 'package:flutter/services.dart';

import 'models/test_user.dart';

class McpClient {
  /// Simulación de un cliente MCP.
  ///
  /// En una implementación real este método podría consultar
  /// un servidor MCP para obtener datos dinámicos.
  static Future<TestUser> getTestUser() async {
    print('Consultando servidor MCP...');

    final jsonString =
        await rootBundle.loadString('assets/test_data/user.json');

    print('Contenido del JSON:');
    print(jsonString);

    final json = jsonDecode(jsonString);

    final user = TestUser.fromJson(json);

    print('Usuario obtenido: ${user.email}');

    return user;
  }
}