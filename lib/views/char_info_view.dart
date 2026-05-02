import 'dart:io';

import 'package:diorite/core/look_n_feel.dart';
import 'package:flutter/material.dart';

class CharInfoView extends StatefulWidget {
  final Map<String, dynamic> info;
  const CharInfoView({super.key, required this.info});

  @override
  State<CharInfoView> createState() => _CharInfoViewState();
}

class _CharInfoViewState extends State<CharInfoView> {
  @override
  Widget build(BuildContext context) {
    var look = LookNFeel(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.info["nombre"]),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text("Eliminar")),
              const PopupMenuItem(child: Text("Editar")),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      File(widget.info["imagenPrincipal"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: look.infoContainer,
                  child: Center(
                    child: Column(
                      children: [
                        Text(widget.info["nombre"], style: look.mainTitle),
                        Text(
                          "Edad: ${widget.info["edad"]}",
                          style: look.subtitle,
                        ),
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
                          text: widget.info["nacionalidad"],
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
                          widget.info["personalidad"],
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
                          widget.info["historia"],
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
    );
  }
}
