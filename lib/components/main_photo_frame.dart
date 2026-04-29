import 'dart:io';

import 'package:diorite/core/look_n_feel.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MainPhotoFrame extends StatelessWidget {
  final Future<File?>? future;
  const MainPhotoFrame({required this.future, super.key});

  @override
  Widget build(BuildContext context) {
    double viewHeight = LookNFeel(context).viewHeight;
    double viewWidth = LookNFeel(context).viewWidth;

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text("Error al cargar imagen");
        }

        final file = snapshot.data;

        if (file == null) {
          return SizedBox(
            height: viewHeight * 0.3,
            child: DottedBorder(
              options: const RectDottedBorderOptions(
                dashPattern: [19, 19],
                strokeWidth: 3,
                color: Color.fromARGB(99, 248, 216, 216),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: viewWidth * .20,
                      color: const Color.fromARGB(185, 248, 216, 216),
                    ),
                    const Text("Añade una foto"),
                  ],
                ),
              ),
            ),
          );
        }

        return Image.file(file);
      },
    );
  }
}
