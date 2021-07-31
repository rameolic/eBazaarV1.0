import 'package:flutter/material.dart';

Widget getButtonWidget({VoidCallback onPressed, Widget child}) =>
    FlatButton(onPressed: onPressed, child: child);
