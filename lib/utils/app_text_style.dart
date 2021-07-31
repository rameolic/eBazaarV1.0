import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';

import 'app_font.dart';

//default style
TextStyle getStyleButton(context) => Theme.of(context).textTheme.button;

TextStyle getStyleOverLine(context) => Theme.of(context).textTheme.overline;

TextStyle getStyleCaption(context) => Theme.of(context).textTheme.caption;

TextStyle getStyleBody1(context) => Theme.of(context).textTheme.body1;

TextStyle getStyleBody2(context) => Theme.of(context).textTheme.body2;

TextStyle getStyleSubHeading(context) => Theme.of(context).textTheme.subhead;

TextStyle getStyleSubTitle(context) => Theme.of(context).textTheme.subtitle;

TextStyle getStyleTitle(context) => Theme.of(context).textTheme.title;

TextStyle getStyleHeading(context) => Theme.of(context).textTheme.headline;

TextStyle getStyleDisplay1(context) => Theme.of(context).textTheme.display1;

TextStyle getStyleDisplay2(context) => Theme.of(context).textTheme.display2;

TextStyle getStyleDisplay3(context) => Theme.of(context).textTheme.display3;

//style : app form style
TextStyle getAppFormTextStyle(context) => getStyleSubTitle(context).copyWith(
      color: colorBlack,
      fontWeight: AppFont.fontWeightSemiBold,
    );

//style : form label text style
TextStyle getFormLabelStyleText(context) =>
    getStyleSubTitle(context).copyWith(color: colorDarkGrey, fontWeight: AppFont.fontWeightSemiBold);

//style : form text content style
TextStyle getFormStyleText(context) =>
    getStyleSubTitle(context).copyWith(color: colorBlack, fontWeight: AppFont.fontWeightSemiBold);

//style : form card title style
TextStyle getFormTitleStyle(context) => getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);

//style : for card normal text
TextStyle getFormNormalTextStyle(context) => getStyleCaption(context).copyWith(color: colorDarkGrey);

//style : for card text navigation
TextStyle getSmallTextNavigationStyle(context) =>
    getStyleBody2(context).copyWith(color: colorAccent, fontWeight: AppFont.fontWeightBold);

//style : app bar title text
TextStyle getAppBarTitleTextStyle(context) =>
    getStyleTitle(context).copyWith(color: colorWhite, fontWeight: AppFont.fontWeightSemiBold);

//style : app search text style
TextStyle getAppSearchTextStyle(context) => getStyleCaption(context).copyWith(
      fontStyle: FontStyle.italic,
    );

//style : app button text style
TextStyle getStyleButtonText(context) =>
    getStyleSubHeading(context).copyWith(color: colorWhite, fontWeight: AppFont.fontWeightSemiBold);

//**********product Item text style***********//

//style : product item name
TextStyle getProductNameTextStyle(context) =>
    getStyleCaption(context).copyWith(color: colorBlack, fontWeight: AppFont.fontWeightMedium);

//style : product view all text style
TextStyle getProductViewAllTextStyle(context) =>
    getStyleBody1(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightSemiBold);

//style : product amount text style
TextStyle getProductAmtTextStyle(context) =>
    getStyleCaption(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightSemiBold);

//style : product Quantity text style
TextStyle getProductQtyTextStyle(context) =>
    getStyleSubHeading(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightSemiBold);

//**********wishList text style***********//

//style: wish list product name text style
TextStyle getWLProductNameTextStyle(context) => getStyleBody2(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);

//style: wish list product Quantity text style
TextStyle getWLProductAmtTextStyle(context) =>
    getStyleBody2(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightBold);

//style: wish list product strike amount text style
TextStyle getWLProductStrikeAmtTextStyle(context) =>
    getStyleBody1(context).copyWith(decoration: TextDecoration.lineThrough);

//style: wish list product strike amount text style
TextStyle getWLProductOfferAmtTextStyle(context) =>
    getStyleCaption(context).copyWith(color: colorFlashGreen, fontWeight: AppFont.fontWeightSemiBold);

//style: wish list product items QTY label text style
TextStyle getWLQtyLabelTextStyle(context) => getStyleCaption(context).copyWith(color: colorBlack);

//style: wish list product items QTY label text style
TextStyle getWLQtyTextStyle(context) =>
    getStyleCaption(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightSemiBold);
