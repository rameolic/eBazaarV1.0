import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';

class CustomEmptyScreen extends StatelessWidget{

  final String imagePath;
  final String shortDescription;
  final String description;
  final String buttonText;
  final BuildContext context;
  final VoidCallback onPressesButton;
  GlobalKey stickyKey = GlobalKey();


  CustomEmptyScreen(this.imagePath, this.shortDescription, this.description, this.buttonText, this.context, {@required this.onPressesButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             //_buildImage(context),
             _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    double width = getScreenWidth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          width: width/1.7,
          image: new AssetImage(imagePath),
        ),
        _verticalSpace(32.0),
        Text(shortDescription, style: getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold, color: colorBlack), textAlign: TextAlign.center, ),
        _verticalSpace(12.0),
        Text(description, style: getStyleCaption(context).copyWith( color: colorDarkGrey, height : 1.5), textAlign: TextAlign.center, ),
        Container(
          margin: EdgeInsets.only(top: 24.0),
          padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 24.0, right: 24.0),

          child: RaisedButton(
            color: colorAccent,
            textColor: Colors.white,
            elevation: 5.0,
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
            child: Text(
              buttonText,
              style: getStyleButtonText(context),
            ),
            onPressed: onPressesButton,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
      ],
    );
  }

  Widget _verticalSpace(double i) {
    return SizedBox(
      height: i,
    );
  }

}

