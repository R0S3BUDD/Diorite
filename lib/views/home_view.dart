import 'package:diorite/core/local_storage_service.dart';
import 'package:diorite/views/new_card_view.dart';
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
      // Método para recargar el las cartas
      _charactersFuture = _loadUserCharacters();
    });
  }

  //Método asíncrono que carga los datos de los personajes desde un archivo json local
  Future<List<CharCard>> _loadUserCharacters() async {
    try {
      List<Map<String, dynamic>> characters = await LocalStorageService()
          .readData("characters.json");

      if (characters.isNotEmpty) {
        List<CharCard> charactersList = characters
            .map(
              (item) => CharCard(info: item),
            ) //Por cada item(map) dentro de la lista, retorna CharCard
            .toList();
        return charactersList;
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
        onPressed: () async {
          final result = await Navigator.push<SaveResult>(
            context,
            MaterialPageRoute(builder: (context) => const NewCardView()),
          );

          if (!context.mounted) return;

          switch (result) {
            case SaveResult.success:
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("¡Carta Guardada!")));
              _refreshCharacters();
              break;

            case SaveResult.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ups... Algo salió mal.")),
              );
              break;

            case SaveResult.aborted:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("¿Te arrepentiste? ;-;")),
              );
              break;

            case null:
              // Esto cubre el caso en que la ruta se cierra sin enviar nada
              break;
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<CharCard>>(
        //Aquì empieza la magia
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
                print(snapshot.error);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.blue,
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
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.start,
                  children: cards,
                ),
              );
            },
      ),
    );
  }
}
