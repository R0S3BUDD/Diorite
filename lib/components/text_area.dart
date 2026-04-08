import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final String label;

  const TextArea(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40, maxHeight: 200),
      child: TextField(
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
