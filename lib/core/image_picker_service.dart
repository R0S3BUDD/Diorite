import 'dart:io';
import 'package:file_selector/file_selector.dart';

class ImagePickerService {
  static final ImagePickerService _instance = ImagePickerService._internal();
  factory ImagePickerService() => _instance;
  ImagePickerService._internal();

  Future<File?> pickImage() async {
    try {
      final typeGroup = XTypeGroup(
        label: "images",
        extensions: ['jpg', 'jpeg', 'png', 'webp'],
      );

      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file != null) {
        return File(file.path);
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR AL SELECCIONAR IMAGEN: $e");
      return null;
    }
  }
}
