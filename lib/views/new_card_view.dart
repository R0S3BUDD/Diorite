import 'package:diorite/components/text_area.dart';
import 'package:flutter/material.dart';

class NewCardView extends StatefulWidget {
  const NewCardView({super.key});

  @override
  State<NewCardView> createState() => _NewCardViewState();
}

class _NewCardViewState extends State<NewCardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                TextField(decoration: InputDecoration(labelText: "Nombre")),
                TextField(decoration: InputDecoration(labelText: "Edad")),
                TextField(
                  decoration: InputDecoration(labelText: "Nacionalidad"),
                ),
                TextArea("Personalidad"),
                TextArea("Historia"),
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
            onPressed: () {},
            child: Text("Agregar Personaje"),
          ),
        ),
      ),
    );
  }
}
