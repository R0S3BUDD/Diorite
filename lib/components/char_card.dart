import 'dart:io';

import 'package:diorite/components/image_placeholder.dart';
import 'package:flutter/material.dart';

class CharCard extends StatelessWidget {
  final Map<String, dynamic> info;

  const CharCard({super.key, required this.info});

  bool get hasImage =>
      info.isNotEmpty &&
      info.containsKey("miniaturaImagen") &&
      info["miniaturaImagen"] != "";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: SizedBox(
        child: Stack(
          children: [
            //imagen ó placeholder
            hasImage
                ? Positioned(child: Image.file(File(info["miniaturaImagen"])))
                : const ImagePlaceholder(),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(bottom: 8, left: 8, right: 8, child: _buildInfo()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    final nombre = info["nombre"] ?? "Sin nombre";
    final edad = info["edad"] ?? "?";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nombre,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          "Edad: $edad",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
