import 'package:flutter/material.dart';

class LookNFeel {
  final BuildContext context;
  LookNFeel(this.context);

  double get viewWidth => MediaQuery.of(context).size.width;
  double get viewHeight => MediaQuery.of(context).size.height;

  TextStyle mainTitle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w500,
    fontFamily: 'ChironGoRoundTC',
  );
  TextStyle subtitle = TextStyle(fontSize: 20, fontFamily: 'ChironGoRoundTC');
  TextStyle multilineText = TextStyle(
    fontFamily: 'Kalam',
    fontWeight: FontWeight.normal,
    fontSize: 15,
  );
  BoxDecoration infoContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Color.fromARGB(255, 208, 217, 221),
  );
}
