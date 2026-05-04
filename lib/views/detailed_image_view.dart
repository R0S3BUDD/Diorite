import 'dart:io';

import 'package:flutter/material.dart';

class DetailedImageView extends StatelessWidget {
  final String path;

  const DetailedImageView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(child: Image.file(File(path), fit: BoxFit.fill)),
      ),
    );
  }
}
