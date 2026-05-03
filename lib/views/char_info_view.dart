import 'dart:io';

import 'package:diorite/core/local_storage_service.dart';
import 'package:diorite/core/look_n_feel.dart';
import 'package:diorite/views/new_card_view.dart';
import 'package:flutter/material.dart';

enum ActionPerformed { None, Deleted, Edited }

class CharInfoView extends StatefulWidget {
  final Map<String, dynamic> info;
  final int selfIndex;
  const CharInfoView({super.key, required this.info, required this.selfIndex});

  @override
  State<CharInfoView> createState() => _CharInfoViewState();
}

class _CharInfoViewState extends State<CharInfoView> {
  final _storage = LocalStorageService();
  Map<String, dynamic> get info => newInfo == null ? widget.info : newInfo!;
  Map<String, dynamic>? newInfo;
  bool edited = false;

  void _refreshView() async {
    newInfo = await _storage.getEntryAt("characters.json", widget.selfIndex);
    setState(() {
      edited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var look = LookNFeel(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              edited ? ActionPerformed.Edited : ActionPerformed.None,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(info["nombre"]),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == "remove") {
                await _storage.deleteEntry("characters.json", widget.selfIndex);
                Navigator.pop(context, ActionPerformed.Deleted);
              }
              if (value == "edit") {
                final result = await Navigator.push<SaveResult>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewCardView(
                      previousInfo: widget.info,
                      cardIndex: widget.selfIndex,
                    ),
                  ),
                );

                switch (result) {
                  case SaveResult.success:
                    _refreshView();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Personaje Editado")),
                    );
                    break;
                  case SaveResult.failure:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ups... Algo salió mal")),
                    );
                    break;
                  case SaveResult.aborted:
                    DoNothingAction();
                    break;
                  default:
                    DoNothingAction();
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "remove", child: Text("Eliminar")),
              const PopupMenuItem(value: "edit", child: Text("Editar")),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 12,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: look.viewHeight * 0.55,
                      minWidth: look.viewWidth,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(
                        File(info["imagenPrincipal"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: look.infoContainer,
                    child: Center(
                      child: Column(
                        children: [
                          Text(info["nombre"], style: look.mainTitle),
                          Text("Edad: ${info["edad"]}", style: look.subtitle),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: look.infoContainer,
                    padding: EdgeInsets.all(8),
                    child: Text.rich(
                      TextSpan(
                        text: "Nacionalidad: ",
                        style: look.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: info["nacionalidad"],
                            style: look.subtitle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: look.infoContainer,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            "Personalidad",
                            style: look.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            info["personalidad"],
                            textAlign: TextAlign.center,
                            style: look.multilineText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: look.infoContainer,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            "Historia",
                            style: look.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            info["historia"],
                            textAlign: TextAlign.center,
                            style: look.multilineText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
