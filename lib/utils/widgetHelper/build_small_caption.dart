import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_colors.dart';


Row buildSmallCaption(String caption, BuildContext context) {
  return Row(
    children: <Widget>[
      Text(
        caption,
        style: getStyleCaption(context).copyWith(color: Colors.black87),
      ),
      Text(
        "*",
        style: getStyleCaption(context).copyWith(color: colorPrimary),
      )
    ],
  );
}