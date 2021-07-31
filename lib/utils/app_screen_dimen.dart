import 'package:flutter/material.dart';

getScreenWidth(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

getScreenHeight(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

bool checkPlatForm(BuildContext context) {
  return Theme.of(context).platform == TargetPlatform.android ? true : false;
}
