import 'package:flutter/material.dart';

class CharCard extends StatelessWidget {
  final double? width;
  final double? height;

  const CharCard({super.key, this.width = 200, this.height = 300});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(padding: const EdgeInsets.all(8.0), child: Placeholder()),
    );
  }
}
