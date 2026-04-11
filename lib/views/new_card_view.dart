import 'package:diorite/components/text_area.dart';
import 'package:diorite/core/local_storage_service.dart';
import 'package:flutter/material.dart';

class NewCardView extends StatefulWidget {
  const NewCardView({super.key});

  @override
  State<NewCardView> createState() => _NewCardViewState();
}

class _NewCardViewState extends State<NewCardView> {
  final TextEditingController _controladorNombre = TextEditingController();
  final TextEditingController _controladorEdad = TextEditingController();
  final TextEditingController _controladorNacionalidad =
      TextEditingController();
  final TextEditingController _controladorPersonalidad =
      TextEditingController();
  final TextEditingController _controladorHistoria = TextEditingController();

  @override
  void dispose() {
    _controladorEdad.dispose();
    _controladorNombre.dispose();
    _controladorHistoria.dispose();
    _controladorNacionalidad.dispose();
    _controladorPersonalidad.dispose();
    super.dispose();
  }

  Future<bool> saveChar() async {
    try {
      Map data = {
        'nombre': _controladorNombre.text,
        'edad': _controladorEdad.text,
        'nacionalidad': _controladorNacionalidad.text,
        'personalidad': _controladorPersonalidad.text,
        'historia': _controladorHistoria.text,
      };
      return await LocalStorageService().saveData("characters.json", data);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Crea una nueva carta"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  controller: _controladorNombre,
                  decoration: InputDecoration(labelText: "Nombre"),
                  onChanged: (value) {},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Edad"),
                  controller: _controladorEdad,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nacionalidad"),
                  controller: _controladorNacionalidad,
                ),
                TextArea("Personalidad", controller: _controladorPersonalidad),
                TextArea("Historia", controller: _controladorHistoria),
                TextButton.icon(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {},
                  label: Text("Añade una foto"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (await saveChar()) {
                Navigator.pop(context, true);
              } else {
                Navigator.pop(context, false);
              }
            },
            child: Text("Agregar Personaje"),
          ),
        ),
      ),
    );
  }
}
