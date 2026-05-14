import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<File> _localFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  static Future<List<dynamic>> readJsonList(String filename) async {
    try {
      final file = await _localFile(filename);
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      if (contents.isEmpty) return [];
      return json.decode(contents) as List<dynamic>;
    } catch (_) {
      return [];
    }
  }

  static Future<void> writeJsonList(String filename, List<dynamic> data) async {
    final file = await _localFile(filename);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(json.encode(data));
  }
}
