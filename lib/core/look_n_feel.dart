import 'package:flutter/material.dart';

class LookNFeel {
  final BuildContext context;
  LookNFeel(this.context);

  double get viewWidth => MediaQuery.of(context).size.width;
  double get viewHeight => MediaQuery.of(context).size.height;
}
