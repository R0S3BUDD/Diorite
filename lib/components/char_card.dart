import 'package:flutter/material.dart';

class CharCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Map<String, dynamic> info;

  const CharCard({
    super.key,
    this.width = 200,
    this.height = 300,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(padding: const EdgeInsets.all(8.0), child: Placeholder()),
    );
  }
}
