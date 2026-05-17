import 'dart:io';

import 'package:diorite/components/gallery_container.dart';
import 'package:diorite/components/main_photo_frame.dart';
import 'package:diorite/components/text_area.dart';
import 'package:diorite/core/image_picker_service.dart';
import 'package:diorite/core/local_storage_service.dart';
import 'package:flutter/material.dart';

enum SaveResult { success, failure, aborted }

class NewCardView extends StatefulWidget {
  final Map<String, dynamic>? previousInfo;
  final int? cardIndex;

  const NewCardView({super.key, this.previousInfo, this.cardIndex});

  @override
  State<NewCardView> createState() => _NewCardViewState();
}

class _NewCardViewState extends State<NewCardView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controladorNombre = TextEditingController();
  final TextEditingController _controladorEdad = TextEditingController();
  final TextEditingController _controladorNacionalidad =
      TextEditingController();
  final TextEditingController _controladorPersonalidad =
      TextEditingController();
  final TextEditingController _controladorHistoria = TextEditingController();

  final LocalStorageService _storage = LocalStorageService();
  final ImagePickerService _imagePicker = ImagePickerService();

  bool _isSaving = false;
  Future<File?>? _futureMainImage;
  File? imageFile;
  bool get isEditing => widget.previousInfo != null && widget.cardIndex != null;
  List<dynamic> gallery = [];

  @override
  void initState() {
    super.initState();

    if (widget.previousInfo != null) {
      final data = widget.previousInfo!;

      _controladorNombre.text = data['nombre'] ?? "";
      _controladorEdad.text = data['edad'] ?? "";
      _controladorNacionalidad.text = data['nacionalidad'] ?? "";
      _controladorPersonalidad.text = data['personalidad'] ?? "";
      _controladorHistoria.text = data['historia'] ?? "";

      if (data['imagenPrincipal'] != null && data['imagenPrincipal'] != "") {
        imageFile = File(data['imagenPrincipal']);
        _futureMainImage = Future.value(imageFile);
      }

      if (data['galeria'] != null && (data['galeria'] as List).isNotEmpty) {
        gallery = data['galeria'];
      }
    }
  }

  Future<File?> futureFile() async {
    try {
      return await _imagePicker.pickImage();
    } catch (e) {
      print("Error al elegir imagen: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _controladorEdad.dispose();
    _controladorNombre.dispose();
    _controladorHistoria.dispose();
    _controladorNacionalidad.dispose();
    _controladorPersonalidad.dispose();
    imageFile = null;
    gallery = [];
    super.dispose();
  }

  Future<SaveResult> _saveChar() async {
    if (!_formKey.currentState!.validate()) {
      return SaveResult.failure;
    }

    setState(() => _isSaving = true);

    try {
      final data = {
        'nombre': _controladorNombre.text.trim(),
        'edad': _controladorEdad.text.trim(),
        'nacionalidad': _controladorNacionalidad.text.trim(),
        'personalidad': _controladorPersonalidad.text.trim(),
        'historia': _controladorHistoria.text.trim(),
        'imagenPrincipal': imageFile?.path ?? "",
        'miniaturaImagen': imageFile != null
            ? await _storage.createThumbnail(imageFile!)
            : "",
        'imagenValida': imageFile == null ? "false" : "true",
        'galeria': gallery,
      };

      if (isEditing) {
        final result = await _storage.updateEntry(
          "characters.json",
          widget.cardIndex!,
          data,
        );
        return result ? SaveResult.success : SaveResult.failure;
      } else {
        final result = await _storage.saveData("characters.json", data);
        return result ? SaveResult.success : SaveResult.failure;
      }
    } catch (_) {
      return SaveResult.failure;
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<bool> _onWillPop() async {
    //This Might be deprecated
    // Aquí puedes agregar lógica más compleja (ej: confirmar si hay cambios)
    Navigator.pop(context, SaveResult.aborted);
    return false; // evita el pop automático
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, SaveResult.aborted);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: isEditing ? Text("Editar personaje") : Text("Crear Personaje"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      GestureDetector(
                        child: MainPhotoFrame(future: _futureMainImage),
                        onTap: () async {
                          final file = await futureFile();

                          if (file != null) {
                            setState(() {
                              imageFile = file;
                              _futureMainImage = Future.value(file);
                            });
                          }
                        },
                      ),
                      TextFormField(
                        controller: _controladorNombre,
                        decoration: const InputDecoration(labelText: "Nombre"),
                      ),
                      TextFormField(
                        controller: _controladorEdad,
                        decoration: const InputDecoration(labelText: "Edad"),
                        validator: (value) => value == null || value.isEmpty
                            ? "Campo requerido"
                            : null,
                      ),
                      TextFormField(
                        controller: _controladorNacionalidad,
                        decoration: const InputDecoration(
                          labelText: "Nacionalidad",
                        ),
                      ),
                      TextArea(
                        "Personalidad",
                        controller: _controladorPersonalidad,
                      ),
                      TextArea("Historia", controller: _controladorHistoria),
                      TextButton.icon(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () async {
                          File? img = await futureFile();
                          if (img != null) {
                            setState(() {
                              gallery.add(img.path);
                            });
                          }
                        },
                        label: const Text("Añade una foto"),
                      ),
                      GaleryContainer(
                        paths: gallery,
                        onRemove: (path) {
                          setState(() {
                            gallery.remove(path);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving
                    ? null
                    : () async {
                        final result = await _saveChar();

                        if (!mounted) return;

                        Navigator.pop(context, result);
                      },
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : isEditing
                    ? Text("Guardar Cambios")
                    : Text("Guardar Personaje"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
