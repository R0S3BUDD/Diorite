import 'package:diorite/components/text_area.dart';
import 'package:diorite/core/local_storage_service.dart';
import 'package:flutter/material.dart';

enum SaveResult { success, failure, aborted }

class NewCardView extends StatefulWidget {
  const NewCardView({super.key});

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

  bool _isSaving = false;

  @override
  void dispose() {
    _controladorEdad.dispose();
    _controladorNombre.dispose();
    _controladorHistoria.dispose();
    _controladorNacionalidad.dispose();
    _controladorPersonalidad.dispose();
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
      };

      final result = await _storage.saveData("characters.json", data);

      return result ? SaveResult.success : SaveResult.failure;
    } catch (_) {
      return SaveResult.failure;
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<bool> _onWillPop() async {
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
          title: const Text("Crea una nueva carta"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: _controladorNombre,
                      decoration: const InputDecoration(labelText: "Nombre"),
                      validator: (value) => value == null || value.isEmpty
                          ? "Campo requerido"
                          : null,
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
                      onPressed: () {},
                      label: const Text("Añade una foto"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
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
                  : const Text("Agregar Personaje"),
            ),
          ),
        ),
      ),
    );
  }
}
