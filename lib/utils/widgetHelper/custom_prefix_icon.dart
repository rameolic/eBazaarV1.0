import 'package:flutter/material.dart';

Widget buildCustomPrefixIcon(IconData iconData) {
  return Container(
    width: 0,
    alignment: Alignment(-0.99, 0.0),
    child: Icon(
      iconData,
      size: 16,
    ),
  );
}
