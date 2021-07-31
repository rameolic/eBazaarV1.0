import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_text_style.dart';

Widget buildAppBar(BuildContext context, String count, String title) {
  return AppBar(
    elevation: 3.0,
    centerTitle: true,
    leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.0,
        )),
    title: Text(
      title,
      style: getAppBarTitleTextStyle(context),
    ),
    /*actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    AppCustomIcon.icon_cart,
                    size: 18,
                  ),
                  tooltip: 'Open shopping cart',
                ),
                Positioned(
                  top: 5,
                  left: 25,
                  height: 17.0,
                  width: 17.0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      count,
                      style: getStyleBody2(context).copyWith(fontSize: 11.0, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]*/
  );
}
