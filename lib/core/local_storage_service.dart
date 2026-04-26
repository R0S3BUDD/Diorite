import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  //Se crea una única instancia de LocalStorageService usando un constructor privado
  //Y se guarda en _instance
  static final LocalStorageService _instance = LocalStorageService._internal();

  //A diferencia de un constructor normal, no crea necesariamente un objeto nuevo.
  //Aquí simplemente devuelve la instancia ya existente (_instance).
  factory LocalStorageService() => _instance;

  //Este es el constructor privado real.
  //El _ lo hace accesible solo dentro del mismo archivo.
  //Nadie fuera de esta clase puede hacer:
  LocalStorageService._internal();

  late Directory _appDirectory;
  Future<void>? _initFuture;

  Future<void> init() {
    print("INICIADO");
    return _initFuture ??= _initialize();

    //TODO: implementar logger
  }

  Future<void> _initialize() async {
    _appDirectory = await getApplicationDocumentsDirectory();
  }

  String _getFilePath(String fileName) {
    return path.join(_appDirectory.path, fileName);
  }

  Future<bool> saveData(String fileName, dynamic data) async {
    try {
      await init();
      final file = File(_getFilePath(fileName));
      var currentData = await readData(fileName);
      currentData.add(data);
      final jsonString = jsonEncode(currentData).toString();
      await file.writeAsString(jsonString);
      return true;
    } catch (e) {
      //TODO: Implementar logger
      print("ERROR AL GUARDAR $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> readData(String fileName) async {
    await init();
    final file = File(_getFilePath(fileName));

    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString("[]");
    }

    final jsonString = await file.readAsString();

    if (jsonString.isEmpty) {
      return [];
    }

    try {
      return (jsonDecode(jsonString) as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } catch (e) {
      await file.writeAsString("[]");
      print("ERROR AL LEER: $e");
      return [];
    }
  }
}
