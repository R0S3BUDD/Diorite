import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:diorite/components/char_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<CharCard>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    //Iniciamos la carga al crear el State
    _charactersFuture = _loadUserCharacters();
  }

  void _refreshCharacters() {
    setState(() {
      _charactersFuture = _loadUserCharacters();
    });
  }

  Future<List<CharCard>> _loadUserCharacters() async {
    try {
      //Lee el archivo
      String content = await rootBundle.loadString('lib/data/characters.json');

      //Si el contenido está vacío, retorna cadena vacía
      if (content.isEmpty) return [];

      //Entrega el contenido como map, clave valor String : lo que sea
      Map<String, dynamic> jsonData = jsonDecode(content);

      if (jsonData.containsKey('characters') &&
          jsonData['characters'] is List) {
        List<dynamic> characterList = jsonData['characters'];

        List<CharCard> cards = characterList.map((item) {
          return CharCard();
        }).toList();

        return cards;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al cargar characters.json: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _refreshCharacters();
          },
          icon: const Icon(Icons.refresh),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<CharCard>>(
        future: _charactersFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<CharCard>> snapshot) {
              //Estado: Cargando
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 36),
                      Text('Cargando tus Cartas'),
                    ],
                  ),
                );
              }

              //Estado: Error
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar las cartas',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshCharacters,
                        child: const Text("Reintentar"),
                      ),
                    ],
                  ),
                );
              }

              //Estado: Datos Cargados
              final List<CharCard> cards = snapshot.data ?? [];

              //Si no hay cartas:
              if (cards.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 80, color: Colors.grey[600]),
                      const SizedBox(height: 16),
                      Text(
                        "No hay elementos",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 167, 143, 143),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Presiona el botón + para añadir una carta",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              //si hay cartas, mostrarlas:
              return SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.start,
                  children: cards.map((card) {
                    return CharCard();
                  }).toList(),
                ),
              );
            },
      ),
    );
  }
}
