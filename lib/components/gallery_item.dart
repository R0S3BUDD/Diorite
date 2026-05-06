import 'dart:io';

import 'package:diorite/core/look_n_feel.dart';
import 'package:diorite/views/detailed_image_view.dart';
import 'package:flutter/material.dart';

class GaleryItem extends StatelessWidget {
  final String path;
  final Function? onRemove;

  const GaleryItem({super.key, required this.path, this.onRemove});

  @override
  Widget build(BuildContext context) {
    var look = LookNFeel(context);

    return ConstrainedBox(
      constraints: look.galeryItem,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailedImageView(path: path);
            },
          ),
        ),
        onLongPress: () => onRemove?.call(path),
        child: Image.file(File(path)),
      ),
    );
  }
}
