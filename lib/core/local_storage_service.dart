import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

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
    return path.join(_appDirectory.path, "CharCardFiles/$fileName");
  }

  Future<bool> saveData(String fileName, dynamic data) async {
    try {
      await init();
      final file = File(_getFilePath(fileName)); //carga el archivo
      var currentData = await readData(fileName); //obtenemos la lista actual
      currentData.add(data); //añadimos la nueva entrada
      final jsonString = jsonEncode(
        currentData,
      ).toString(); //codifica la lista a json, y convierte en sting
      await file.writeAsString(
        jsonString,
      ); //Escribe la nueva lista en el archivo
      return true; //listo!
    } catch (e) {
      //TODO: Implementar logger
      print("ERROR AL GUARDAR $e");
      return false;
    }
  }

  Future<bool> deleteEntry(String fileName, int index) async {
    try {
      await init();
      final file = File(_getFilePath(fileName));
      var currentData = await readData(fileName);
      final thumb = File(currentData[index]["miniaturaImagen"]);
      await thumb.delete();
      currentData.removeAt(index);
      final jsonString = jsonEncode(currentData).toString();
      await file.writeAsString(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateEntry(
    String fileName,
    int index,
    Map<String, dynamic> data,
  ) async {
    try {
      await init();
      final file = File(_getFilePath(fileName));
      var currentData = await readData(fileName);
      currentData[index] = data;
      final jsonString = jsonEncode(currentData).toString();
      await file.writeAsString(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getEntryAt(String fileName, int index) async {
    try {
      await init();
      var currentData = await readData(fileName);
      return currentData[index];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> readData(String fileName) async {
    await init();
    final file = File(_getFilePath(fileName)); //carga el archivo

    if (!await file.exists()) {
      //No existe??
      await file.create(recursive: true); //Créalo
      await file.writeAsString("[]"); //formatea
    }

    final jsonString = await file.readAsString(); //léelo

    if (jsonString.isEmpty) {
      //¿Este caso puede pasar?
      return [];
    }

    try {
      return (jsonDecode(jsonString)
              as List) //Decodifica el formato json, importa como lista
          .map(
            (e) => Map<String, dynamic>.from(e),
          ) //Toma cada elemento de la lista e interpreta como map
          .toList(); //Transforma todo en una lista
    } catch (e) {
      //algo salió mal?
      await file.writeAsString("[]"); //reinicia la lista
      print("ERROR AL LEER: $e");
      return [];
    }
  }

  Future<String?> createThumbnail(File originalFile) async {
    try {
      await init();

      // Leer bytes
      final bytes = await originalFile.readAsBytes();

      // Decodificar imagen
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      // Redimensionar (puedes ajustar el tamaño)
      final thumbnail = img.copyResize(
        image,
        width: 250, // tamaño típico de thumbnail
      );

      // Construir nombre nuevo
      final originalName = path.basenameWithoutExtension(originalFile.path);
      final extension = path.extension(originalFile.path);

      final thumbName = "${originalName}_thumb$extension";

      // Guardar en el directorio de la app
      final thumbPath = path.join(
        _appDirectory.path,
        "CharCardFiles",
        thumbName,
      );

      final thumbFile = File(thumbPath);

      // Codificar y guardar
      final encoded = img.encodeJpg(thumbnail, quality: 75);

      await thumbFile.writeAsBytes(encoded);

      return thumbFile.path;
    } catch (e) {
      print("ERROR AL CREAR THUMBNAIL: $e");
      return null;
    }
  }
}
