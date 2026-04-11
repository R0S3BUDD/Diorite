import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextArea(this.label, {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40, maxHeight: 200),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .5)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: .5)),
        ),
      ),
    );
  }
}
