import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';

import '../app_constants.dart';
import '../app_text_style.dart';

class AlertOverlay extends StatefulWidget {
  String title, subTitle, buttonTitle;
  AlertOverlay(this.title, this.subTitle, this.buttonTitle);
  @override
  State<StatefulWidget> createState() =>
      AlertOverlayState(this.title, this.subTitle, this.buttonTitle);
}

class AlertOverlayState extends State<AlertOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  String title, subTitle, buttonTitle;
  AlertOverlayState(this.title, this.subTitle, this.buttonTitle);
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  widget.title,
                                  style: getStyleButtonText(context).copyWith(
                                      color: colorBlack,
                                      letterSpacing: 1,
                                      fontWeight: AppFont.fontWeightExtraBold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: AppConstants.SIDE_MARGIN / 4,
                                ),
                                Text(
                                  widget.subTitle,
                                  style: getStyleButtonText(context).copyWith(
                                      color: colorBlack,
                                      fontWeight: AppFont.fontWeightRegular,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: AppConstants.SIDE_MARGIN / 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: AppConstants.SIDE_MARGIN * 4,
                                      height: 45,
                                      child: RaisedButton(
                                        highlightElevation: 8.0,
                                        onPressed: () {
                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : '';
                                        },
                                        color: colorDarkRed,
                                        textColor: colorWhite,
                                        elevation: 1,
                                        padding: EdgeInsets.only(
                                            top: AppConstants.SIDE_MARGIN / 1.5,
                                            bottom:
                                                AppConstants.SIDE_MARGIN / 1.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    AppConstants.SIDE_MARGIN))),
                                        child: Text(
                                          widget.buttonTitle,
                                          style: getStyleButtonText(context)
                                              .copyWith(
                                                  color: colorWhite,
                                                  letterSpacing: 1,
                                                  fontWeight:
                                                      AppFont.fontWeightBold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]))),
                ],
              )),
        ),
      ),
    );
  }
}
