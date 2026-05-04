import 'package:diorite/components/galery_item.dart';
import 'package:diorite/core/look_n_feel.dart';
import 'package:flutter/material.dart';

class GaleryContainer extends StatefulWidget {
  final List<dynamic> paths;

  const GaleryContainer({super.key, required this.paths});

  @override
  State<GaleryContainer> createState() => _GaleryContainerState();
}

class _GaleryContainerState extends State<GaleryContainer> {
  @override
  Widget build(BuildContext context) {
    var look = LookNFeel(context);

    return SizedBox(
      width: look.viewWidth,
      child: Center(
        child: Wrap(
          spacing: 8,
          children: widget.paths.map((path) {
            return GaleryItem(path: path);
          }).toList(),
        ),
      ),
    );
  }
}
